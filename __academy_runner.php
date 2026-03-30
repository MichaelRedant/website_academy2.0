<?php
declare(strict_types=1);

/**
 * Persistent deploy/admin runner for hosts without SSH.
 *
 * Usage:
 *   /__academy_runner.php?token=...&action=sync
 *
 * Actions:
 *   - help
 *   - sync
 *   - import
 *   - repair
 *   - admin
 *   - import-user
 *   - clear
 *   - optimize
 */

header('Content-Type: text/plain; charset=UTF-8');
@ini_set('display_errors', '1');
@ini_set('display_startup_errors', '1');
error_reporting(E_ALL);

$tokenExpected = '8141e4f7b98891883f8a1a9d8d0780ac7e1a57804e1909d3';
$tokenProvided = (string) ($_REQUEST['token'] ?? '');
$action = strtolower(trim((string) ($_REQUEST['action'] ?? 'help')));

if ($tokenProvided === '' || !hash_equals($tokenExpected, $tokenProvided)) {
    http_response_code(403);
    echo "Forbidden\n";
    exit(1);
}

$appBase = __DIR__.'/academy_app';
$autoloadPath = $appBase.'/vendor/autoload.php';
$bootstrapPath = $appBase.'/bootstrap/app.php';
$lockPath = $appBase.'/storage/app/deploy_runner.lock';

if (!is_dir($appBase) || !is_file($autoloadPath) || !is_file($bootstrapPath)) {
    http_response_code(500);
    echo "Academy app pad ontbreekt of is onvolledig.\n";
    echo "Verwacht: {$appBase}\n";
    exit(1);
}

$supportedActions = ['help', 'sync', 'import', 'repair', 'admin', 'import-user', 'clear', 'optimize'];
if (!in_array($action, $supportedActions, true)) {
    http_response_code(400);
    echo "Onbekende action: {$action}\n";
    echo "Gebruik: ".implode(', ', $supportedActions)."\n";
    exit(1);
}

if ($action === 'help') {
    echo "Academy runner is bereikbaar.\n";
    echo "Acties: ".implode(', ', $supportedActions)."\n";
    echo "Voorbeeld: ?token=***&action=sync\n";
    exit(0);
}

if (is_file($lockPath)) {
    http_response_code(409);
    echo "Runner is al bezig of lock werd niet opgeruimd.\n";
    echo "Lock: {$lockPath}\n";
    exit(1);
}

@file_put_contents($lockPath, 'locked at '.date('c').PHP_EOL);
register_shutdown_function(static function () use ($lockPath): void {
    if (is_file($lockPath)) {
        @unlink($lockPath);
    }
});

set_time_limit(0);

try {
    require $autoloadPath;

    /** @var \Illuminate\Foundation\Application $app */
    $app = require $bootstrapPath;
    $kernel = $app->make(\Illuminate\Contracts\Console\Kernel::class);
    $kernel->bootstrap();

    $adminEmail = trim((string) ($_REQUEST['admin_email'] ?? env('ACADEMY_ADMIN_EMAIL', 'admin@octopusacademy.test')));
    $adminPassword = (string) ($_REQUEST['admin_password'] ?? env('ACADEMY_ADMIN_PASSWORD', 'OctopusAdmin!2026'));
    $adminName = trim((string) ($_REQUEST['admin_name'] ?? env('ACADEMY_ADMIN_NAME', 'Octopus Admin')));
    $importEmail = trim((string) ($_REQUEST['import_email'] ?? ''));
    $importName = trim((string) ($_REQUEST['import_name'] ?? ''));
    $importRole = trim((string) ($_REQUEST['import_role'] ?? 'learner'));
    $importPassword = (string) ($_REQUEST['import_password'] ?? '');
    $importFile = trim((string) ($_REQUEST['import_file'] ?? '../src/exportOld.json'));

/**
 * @param array<string, mixed> $arguments
 */
function run_runner_artisan(string $command, array $arguments = []): int
{
    $args = array_merge(['command' => $command], $arguments);
    $exitCode = \Illuminate\Support\Facades\Artisan::call($command, $args);
    $output = trim(\Illuminate\Support\Facades\Artisan::output());

    echo ">>> {$command}";
    if ($arguments !== []) {
        echo ' '.json_encode($arguments, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }
    echo "\n";
    if ($output !== '') {
        echo $output."\n";
    }
    echo "[exit={$exitCode}]\n\n";

    return $exitCode;
}

/**
 * @param list<array{command:string,arguments:array<string,mixed>}> $steps
 */
function run_steps(array $steps): int
{
    foreach ($steps as $step) {
        $exitCode = run_runner_artisan($step['command'], $step['arguments']);
        if ($exitCode !== 0) {
            return $exitCode;
        }
    }

    return 0;
}

$exitCode = 0;

if ($action === 'clear') {
    $exitCode = run_runner_artisan('optimize:clear');
} elseif ($action === 'optimize') {
    $exitCode = run_runner_artisan('optimize');
} elseif ($action === 'import') {
    $exitCode = run_runner_artisan('academy:import-content', [
        '--reset-orders' => true,
        '--no-interaction' => true,
    ]);
} elseif ($action === 'repair') {
    $exitCode = run_runner_artisan('academy:repair-legacy-content', [
        '--no-interaction' => true,
    ]);
} elseif ($action === 'admin') {
    $ensureAdminExit = run_runner_artisan('academy:ensure-admin', [
        '--email' => $adminEmail,
        '--password' => $adminPassword,
        '--name' => $adminName,
        '--no-interaction' => true,
    ]);

    if ($ensureAdminExit !== 0) {
        echo "academy:ensure-admin faalde, fallback LocalAdminUserSeeder...\n\n";
        $exitCode = run_runner_artisan('db:seed', [
            '--class' => 'LocalAdminUserSeeder',
            '--force' => true,
            '--no-interaction' => true,
        ]);
    } else {
        $exitCode = 0;
    }
} elseif ($action === 'import-user') {
    if ($importEmail === '' || $importPassword === '') {
        http_response_code(400);
        echo "import-user vereist import_email en import_password.\n";
        exit(1);
    }

    $exitCode = run_runner_artisan('academy:import-users', [
        '--file' => $importFile,
        '--email' => $importEmail,
        '--name' => $importName,
        '--role' => $importRole,
        '--default-password' => $importPassword,
        '--no-interaction' => true,
    ]);
} elseif ($action === 'sync') {
    $exitCode = run_steps([
        ['command' => 'optimize:clear', 'arguments' => []],
        ['command' => 'migrate', 'arguments' => ['--force' => true, '--no-interaction' => true]],
        ['command' => 'db:seed', 'arguments' => ['--class' => 'RolesAndPermissionsSeeder', '--force' => true, '--no-interaction' => true]],
        ['command' => 'db:seed', 'arguments' => ['--class' => 'TaxonomySeeder', '--force' => true, '--no-interaction' => true]],
    ]);

    if ($exitCode === 0) {
        $ensureAdminExit = run_runner_artisan('academy:ensure-admin', [
            '--email' => $adminEmail,
            '--password' => $adminPassword,
            '--name' => $adminName,
            '--no-interaction' => true,
        ]);

        if ($ensureAdminExit !== 0) {
            echo "academy:ensure-admin faalde, fallback LocalAdminUserSeeder...\n\n";
            $exitCode = run_runner_artisan('db:seed', [
                '--class' => 'LocalAdminUserSeeder',
                '--force' => true,
                '--no-interaction' => true,
            ]);
        }
    }

    if ($exitCode === 0) {
        $exitCode = run_runner_artisan('academy:import-content', [
            '--reset-orders' => true,
            '--no-interaction' => true,
        ]);
    }

    if ($exitCode === 0) {
        $exitCode = run_runner_artisan('academy:repair-legacy-content', [
            '--no-interaction' => true,
        ]);
    }

    if ($exitCode === 0) {
        $exitCode = run_runner_artisan('optimize');
    }
}

    if ($exitCode !== 0) {
        http_response_code(500);
        echo "Runner klaar met fouten (action={$action}).\n";
        exit($exitCode);
    }

    echo "Runner klaar (action={$action}).\n";
    exit(0);
} catch (\Throwable $e) {
    http_response_code(500);
    echo "Runner exception\n";
    echo "Type: ".get_class($e)."\n";
    echo "Message: ".$e->getMessage()."\n";
    echo "File: ".$e->getFile().':'.$e->getLine()."\n";

    $trace = $e->getTraceAsString();
    echo "Trace:\n".$trace."\n";
    exit(1);
}
