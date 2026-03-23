<?php
error_reporting(E_ALL);
ini_set('display_errors', '1');
$basePath = getcwd();
$howtosPath = $basePath . '/monolith/data/howtos.php';
$coursesPath = $basePath . '/monolith/data/courses.php';
$sitemapPath = $basePath . '/audit/raw_sitemaps/sfwd-lessons-sitemap.xml';
$legacyCategoryApiUrl = 'https://academy.octopus.be/nl/wp-json/wp/v2/ld_lesson_category?per_page=100';

$existing = require $howtosPath;
$courses = require $coursesPath;

$defaultCategoriesByCourse = [
    'coda' => ['bank', 'boekhoudprogramma'],
    'documenten-doorsturen-via-dms' => ['boekhoudprogramma', 'dms'],
    'hoe-een-boeking-inbrengen' => ['basis', 'boekhoudprogramma'],
    'klantenportaal' => ['klantenportaal'],
    'lijsten-in-octopus' => ['boekhoudprogramma', 'lijsten'],
    'menu-beheer' => ['boekhoudprogramma', 'specifieke-functionaliteiten'],
    'met-het-pakket-starten' => ['ontdek', 'boekhoudprogramma-ontdek', 'klantenportaal-ontdek'],
    'octopus-webinars' => ['nieuw', 'webinars', 'updates'],
    'ondernemer-facturatie' => ['boekhoudprogramma', 'facturatie-boekhoudprogramma'],
    'peppol' => ['boekhoudprogramma', 'facturatie-boekhoudprogramma', 'specifieke-functionaliteiten'],
];

$existingByNormalizedUrl = [];
foreach ($existing as $entry) {
    $normalized = normalize_legacy_url((string)($entry['legacy_url'] ?? ''));
    if ($normalized !== '') {
        $existingByNormalizedUrl[$normalized] = $entry;
    }
}

$legacyCourseLessonLinks = [];
foreach ($courses as $course) {
    $courseUrl = (string)($course['legacy_url'] ?? '');
    if ($courseUrl === '') {
        continue;
    }

    $html = @file_get_contents($courseUrl);
    if ($html === false) {
        fwrite(STDERR, "Could not fetch course url: $courseUrl\n");
        continue;
    }

    if (!preg_match_all('~/nl/Cursussen/([^/]+)/lessons/([^/]+)/~i', $html, $matches, PREG_SET_ORDER)) {
        continue;
    }

    foreach ($matches as $match) {
        $courseSlug = slugify($match[1]);
        $lessonSlug = slugify($match[2]);
        if ($courseSlug === '' || $lessonSlug === '') {
            continue;
        }

        $legacyCourseLessonLinks[$courseSlug . '|' . $lessonSlug] = [
            'course_slug' => $courseSlug,
            'lesson_slug' => $lessonSlug,
            'legacy_url' => 'https://academy.octopus.be/nl/Cursussen/' . $courseSlug . '/lessons/' . $lessonSlug . '/',
        ];
    }
}

$entriesByKey = [];

foreach ($legacyCourseLessonLinks as $item) {
    $normalized = normalize_legacy_url($item['legacy_url']);

    if (isset($existingByNormalizedUrl[$normalized])) {
        $entriesByKey[$normalized] = normalize_entry($existingByNormalizedUrl[$normalized]);
        continue;
    }

    $entriesByKey[$normalized] = [
        'title' => title_from_slug($item['lesson_slug']),
        'legacy_url' => $item['legacy_url'],
        'category_slugs' => $defaultCategoriesByCourse[$item['course_slug']] ?? [],
        'excerpt' => null,
        'video_hosts' => [],
    ];
}

$missingFromCoursePages = [];
$xml = @file_get_contents($sitemapPath);
if ($xml !== false && preg_match_all('~<loc>https://academy\\.octopus\\.be/nl/lessons/([^/]+)/</loc>~i', $xml, $m)) {
    $lessonSlugsFromSitemap = array_values(array_unique(array_map('slugify', $m[1])));
    foreach ($lessonSlugsFromSitemap as $lessonSlug) {
        if ($lessonSlug === '') {
            continue;
        }

        $alreadyPresent = false;
        foreach ($legacyCourseLessonLinks as $item) {
            if ($item['lesson_slug'] === $lessonSlug) {
                $alreadyPresent = true;
                break;
            }
        }

        if ($alreadyPresent) {
            continue;
        }

        $courseSlug = infer_course_for_orphan_lesson($lessonSlug);
        $legacyUrl = 'https://academy.octopus.be/nl/Cursussen/' . $courseSlug . '/lessons/' . $lessonSlug . '/';
        $normalized = normalize_legacy_url($legacyUrl);

        if (!isset($entriesByKey[$normalized])) {
            $entriesByKey[$normalized] = [
                'title' => title_from_slug($lessonSlug),
                'legacy_url' => $legacyUrl,
                'category_slugs' => $defaultCategoriesByCourse[$courseSlug] ?? [],
                'excerpt' => null,
                'video_hosts' => [],
            ];
        }

        $missingFromCoursePages[] = $lessonSlug;
    }
}

[$lessonCategoriesByLessonSlug, $legacyCategoryMetaBySlug] = collect_lesson_categories_by_legacy_archive($legacyCategoryApiUrl);
$categoriesResolvedFromLegacy = 0;
$categoriesFallbackUsed = 0;

foreach ($entriesByKey as &$entry) {
    $legacyUrl = (string)($entry['legacy_url'] ?? '');
    $parsed = parse_legacy_course_and_lesson_slugs($legacyUrl);
    $courseSlug = $parsed['course_slug'] ?? null;
    $lessonSlug = $parsed['lesson_slug'] ?? null;

    if (is_string($lessonSlug) && isset($lessonCategoriesByLessonSlug[$lessonSlug])) {
        $entry['category_slugs'] = sort_category_slugs(array_keys($lessonCategoriesByLessonSlug[$lessonSlug]));
        $categoriesResolvedFromLegacy++;
        continue;
    }

    $fallbackCategorySlugs = array_values(array_unique(array_map('strval', (array)($entry['category_slugs'] ?? []))));
    if ($fallbackCategorySlugs === [] && is_string($courseSlug)) {
        $fallbackCategorySlugs = $defaultCategoriesByCourse[$courseSlug] ?? [];
    }

    if ($fallbackCategorySlugs === [] && is_string($lessonSlug)) {
        $inferredCourseSlug = infer_course_for_orphan_lesson($lessonSlug);
        $fallbackCategorySlugs = $defaultCategoriesByCourse[$inferredCourseSlug] ?? [];
    }

    $entry['category_slugs'] = sort_category_slugs($fallbackCategorySlugs);
    $categoriesFallbackUsed++;
}
unset($entry);

$finalEntries = array_values($entriesByKey);
usort($finalEntries, static function (array $a, array $b): int {
    return strcmp(strtolower((string)$a['title']), strtolower((string)$b['title']));
});

$php = "<?php\n\nreturn [\n";
foreach ($finalEntries as $entry) {
    $php .= "    [\n";
    $php .= "        'title' => " . var_export((string)$entry['title'], true) . ",\n";
    $php .= "        'legacy_url' => " . var_export((string)$entry['legacy_url'], true) . ",\n";
    $php .= "        'category_slugs' => [\n";
    foreach (($entry['category_slugs'] ?? []) as $categorySlug) {
        $php .= "            " . var_export((string)$categorySlug, true) . ",\n";
    }
    $php .= "        ],\n";
    $php .= "        'excerpt' => " . var_export($entry['excerpt'], true) . ",\n";
    $php .= "        'video_hosts' => [\n";
    foreach (($entry['video_hosts'] ?? []) as $host) {
        $php .= "            " . var_export((string)$host, true) . ",\n";
    }
    $php .= "        ],\n";
    $php .= "    ],\n";
}
$php .= "];\n";

file_put_contents($howtosPath, $php);

echo 'howtos_count=' . count($finalEntries) . PHP_EOL;
echo 'course_page_links=' . count($legacyCourseLessonLinks) . PHP_EOL;
echo 'inferred_from_sitemap=' . count($missingFromCoursePages) . PHP_EOL;
echo 'legacy_category_terms=' . count($legacyCategoryMetaBySlug) . PHP_EOL;
echo 'categories_resolved_from_legacy=' . $categoriesResolvedFromLegacy . PHP_EOL;
echo 'categories_fallback_used=' . $categoriesFallbackUsed . PHP_EOL;
if ($missingFromCoursePages !== []) {
    echo 'inferred_slugs=' . implode(',', $missingFromCoursePages) . PHP_EOL;
}

function normalize_entry(array $entry): array
{
    return [
        'title' => (string)($entry['title'] ?? ''),
        'legacy_url' => (string)($entry['legacy_url'] ?? ''),
        'category_slugs' => array_values(array_map('strval', (array)($entry['category_slugs'] ?? []))),
        'excerpt' => $entry['excerpt'] ?? null,
        'video_hosts' => array_values(array_map('strval', (array)($entry['video_hosts'] ?? []))),
    ];
}

function normalize_legacy_url(string $url): string
{
    $url = trim(html_entity_decode($url, ENT_QUOTES | ENT_HTML5));
    if ($url === '') {
        return '';
    }

    $parts = parse_url($url);
    if (!is_array($parts)) {
        return '';
    }

    $path = (string)($parts['path'] ?? '');
    if ($path === '') {
        return '';
    }

    $path = rawurldecode($path);
    $path = preg_replace('~/+~', '/', $path) ?? $path;
    $path = rtrim($path, '/');

    return strtolower($path);
}

function slugify(string $value): string
{
    $value = strtolower(trim($value));
    $value = preg_replace('~[^a-z0-9]+~', '-', $value) ?? $value;
    return trim($value, '-');
}

function title_from_slug(string $slug): string
{
    $title = ucwords(str_replace('-', ' ', $slug));
    $replacements = [
        'Dms' => 'DMS',
        'Coda' => 'CODA',
        'Peppol' => 'Peppol',
        'Kpi' => 'KPI',
        'Pdf' => 'PDF',
    ];

    return strtr($title, $replacements);
}

function infer_course_for_orphan_lesson(string $lessonSlug): string
{
    if (str_contains($lessonSlug, 'klantenportaal') || str_contains($lessonSlug, 'factuuropmaak')) {
        return 'klantenportaal';
    }

    if (str_contains($lessonSlug, 'dms') || str_contains($lessonSlug, 'uploaden-doc')) {
        return 'documenten-doorsturen-via-dms';
    }

    if (str_contains($lessonSlug, 'balans')) {
        return 'lijsten-in-octopus';
    }

    if (str_contains($lessonSlug, 'aankoopfactuur') || str_contains($lessonSlug, 'beroepsgedeelte')) {
        return 'hoe-een-boeking-inbrengen';
    }

    if (preg_match('~^les-[0-9]+$~', $lessonSlug)) {
        return 'octopus-webinars';
    }

    return 'klantenportaal';
}

/**
 * @return array{
 *     0: array<string, array<string, bool>>,
 *     1: array<string, array{count:int,parent_id:int,parent_slug:?string}>
 * }
 */
function collect_lesson_categories_by_legacy_archive(string $legacyCategoryApiUrl): array
{
    $rawJson = @file_get_contents($legacyCategoryApiUrl);
    if (!is_string($rawJson) || $rawJson === '') {
        return [[], []];
    }

    $terms = json_decode($rawJson, true);
    if (!is_array($terms)) {
        return [[], []];
    }

    $idToSlug = [];
    $metaBySlug = [];

    foreach ($terms as $term) {
        if (!is_array($term)) {
            continue;
        }

        $slug = slugify((string)($term['slug'] ?? ''));
        if ($slug === '') {
            continue;
        }

        $id = (int)($term['id'] ?? 0);
        if ($id > 0) {
            $idToSlug[$id] = $slug;
        }

        $metaBySlug[$slug] = [
            'count' => (int)($term['count'] ?? 0),
            'parent_id' => (int)($term['parent'] ?? 0),
            'parent_slug' => null,
        ];
    }

    foreach ($metaBySlug as &$meta) {
        $parentId = (int)($meta['parent_id'] ?? 0);
        $meta['parent_slug'] = $parentId > 0 ? ($idToSlug[$parentId] ?? null) : null;
    }
    unset($meta);

    $lessonCategoriesByLessonSlug = [];

    foreach ($metaBySlug as $categorySlug => $meta) {
        if ((int)($meta['count'] ?? 0) <= 0) {
            continue;
        }

        $page = 1;
        while ($page <= 40) {
            $archiveUrl = $page === 1
                ? 'https://academy.octopus.be/nl/lesson-category/' . $categorySlug . '/'
                : 'https://academy.octopus.be/nl/lesson-category/' . $categorySlug . '/page/' . $page . '/';

            $html = @file_get_contents($archiveUrl);
            if (!is_string($html) || $html === '') {
                break;
            }

            if (preg_match('~<title>\s*Pagina niet gevonden~i', $html) === 1) {
                break;
            }

            $lessonSlugs = extract_lesson_slugs_from_archive_html($html);
            if ($lessonSlugs === []) {
                break;
            }

            foreach ($lessonSlugs as $lessonSlug) {
                $lessonCategoriesByLessonSlug[$lessonSlug][$categorySlug] = true;
            }

            $hasNextPage = preg_match('~<link\s+rel=(["\'])next\1~i', $html) === 1
                || preg_match('~class=(["\'])next page-numbers\1~i', $html) === 1;
            if (!$hasNextPage) {
                break;
            }

            $page++;
        }
    }

    foreach ($lessonCategoriesByLessonSlug as $lessonSlug => $categorySet) {
        foreach (array_keys($categorySet) as $slug) {
            $parentSlug = $metaBySlug[$slug]['parent_slug'] ?? null;
            while (is_string($parentSlug) && $parentSlug !== '') {
                $lessonCategoriesByLessonSlug[$lessonSlug][$parentSlug] = true;
                $parentSlug = $metaBySlug[$parentSlug]['parent_slug'] ?? null;
            }
        }
    }

    return [$lessonCategoriesByLessonSlug, $metaBySlug];
}

/**
 * @return list<string>
 */
function extract_lesson_slugs_from_archive_html(string $html): array
{
    if (!preg_match_all(
        '~(?:https://academy\\.octopus\\.be)?/nl/(?:Cursussen/[^/]+/)?lessons/([^/"\'#?]+)/~i',
        $html,
        $matches
    )) {
        return [];
    }

    $slugs = [];
    foreach ($matches[1] as $rawLessonSlug) {
        $lessonSlug = slugify((string)$rawLessonSlug);
        if ($lessonSlug === '') {
            continue;
        }

        $slugs[$lessonSlug] = true;
    }

    return array_keys($slugs);
}

/**
 * @return array{course_slug:string,lesson_slug:string}|null
 */
function parse_legacy_course_and_lesson_slugs(string $legacyUrl): ?array
{
    $path = (string)parse_url($legacyUrl, PHP_URL_PATH);
    if ($path === '') {
        return null;
    }

    if (!preg_match('~/(?:[a-z]{2}/)?Cursussen/([^/]+)/lessons/([^/]+)/?~i', $path, $matches)) {
        return null;
    }

    $courseSlug = slugify(rawurldecode($matches[1]));
    $lessonSlug = slugify(rawurldecode($matches[2]));
    if ($courseSlug === '' || $lessonSlug === '') {
        return null;
    }

    return [
        'course_slug' => $courseSlug,
        'lesson_slug' => $lessonSlug,
    ];
}

/**
 * @param list<string> $categorySlugs
 * @return list<string>
 */
function sort_category_slugs(array $categorySlugs): array
{
    $priority = [
        'ontdek' => 10,
        'klantenportaal' => 20,
        'boekhoudprogramma' => 30,
        'nieuw' => 40,
        'klantenportaal-ontdek' => 110,
        'boekhoudprogramma-ontdek' => 111,
        'introductie' => 120,
        'starten-met-het-klantenportaal' => 121,
        'aanleveren-van-documenten' => 122,
        'extra-functionaliteiten' => 123,
        'facturatie' => 124,
        'betalingen' => 125,
        'introductie-boekhoudprogramma' => 130,
        'starten-met-het-boekhoudprogramma' => 131,
        'basis' => 132,
        'lijsten' => 133,
        'specifieke-functionaliteiten' => 134,
        'facturatie-boekhoudprogramma' => 135,
        'dms' => 136,
        'bank' => 137,
        'updates' => 140,
        'webinars' => 141,
    ];

    $normalized = [];
    foreach ($categorySlugs as $slug) {
        $normalizedSlug = slugify((string)$slug);
        if ($normalizedSlug === '') {
            continue;
        }

        $normalized[$normalizedSlug] = true;
    }

    $sorted = array_keys($normalized);
    usort($sorted, static function (string $a, string $b) use ($priority): int {
        $weightA = $priority[$a] ?? 900;
        $weightB = $priority[$b] ?? 900;

        if ($weightA !== $weightB) {
            return $weightA <=> $weightB;
        }

        return strcmp($a, $b);
    });

    return $sorted;
}
