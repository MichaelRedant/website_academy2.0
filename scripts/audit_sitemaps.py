#!/usr/bin/env python3
"""
Generate a sitemap inventory and migration-friendly audit files.

Usage:
  python scripts/audit_sitemaps.py
  python scripts/audit_sitemaps.py --sitemap-index https://academy.octopus.be/nl/sitemap_index.xml
"""

from __future__ import annotations

import argparse
import csv
import datetime as dt
import ssl
import urllib.parse
import urllib.request
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict
from pathlib import Path


DEFAULT_SITEMAP_INDEX = "https://academy.octopus.be/nl/sitemap_index.xml"


def local_name(tag: str) -> str:
    if "}" in tag:
        return tag.split("}", 1)[1]
    return tag


def child_text(element: ET.Element, child_tag: str) -> str:
    for child in list(element):
        if local_name(child.tag) == child_tag and child.text:
            return child.text.strip()
    return ""


def fetch_url(url: str, verify_ssl: bool, timeout: int = 60) -> bytes:
    context = None
    if not verify_ssl:
        context = ssl.create_default_context()
        context.check_hostname = False
        context.verify_mode = ssl.CERT_NONE

    request = urllib.request.Request(
        url=url,
        headers={
            "User-Agent": "academy-migration-audit/1.0",
            "Accept": "application/xml,text/xml,*/*",
        },
    )
    with urllib.request.urlopen(request, context=context, timeout=timeout) as response:
        return response.read()


def parse_sitemap_index(xml_bytes: bytes) -> list[str]:
    root = ET.fromstring(xml_bytes)
    urls: list[str] = []
    for node in list(root):
        if local_name(node.tag) != "sitemap":
            continue
        loc = child_text(node, "loc")
        if loc:
            urls.append(loc)
    return urls


def parse_urlset(xml_bytes: bytes) -> list[dict[str, str]]:
    root = ET.fromstring(xml_bytes)
    rows: list[dict[str, str]] = []
    for node in list(root):
        if local_name(node.tag) != "url":
            continue
        loc = child_text(node, "loc")
        if not loc:
            continue
        rows.append(
            {
                "url": loc,
                "lastmod": child_text(node, "lastmod"),
            }
        )
    return rows


def detect_content_type(source_sitemap: str) -> str:
    source = source_sitemap.lower()
    if "page-sitemap" in source:
        return "page"
    if "sfwd-courses-sitemap" in source:
        return "course"
    if "sfwd-lessons-sitemap" in source:
        return "lesson"
    if "ld_course_category-sitemap" in source:
        return "course-category"
    if "ld_course_tag-sitemap" in source:
        return "course-tag"
    if "video-sitemap" in source:
        return "video-entry"
    return "other"


def path_from_url(url: str) -> str:
    parsed = urllib.parse.urlparse(url)
    return parsed.path or "/"


def has_uppercase_path(path: str) -> bool:
    return any(char.isupper() for char in path)


def is_suspected_test_page(path: str) -> bool:
    lowered = path.lower()
    return any(token in lowered for token in ("/elementor-", "/test-", "/sandbox-", "/staging-"))


def normalized_path_key(path: str) -> str:
    cleaned = path.strip()
    if not cleaned:
        return "/"
    if cleaned != "/":
        cleaned = cleaned.rstrip("/")
    cleaned = cleaned.lower()
    return cleaned or "/"


def ensure_output_dirs(output_dir: Path) -> tuple[Path, Path]:
    output_dir.mkdir(parents=True, exist_ok=True)
    raw_dir = output_dir / "raw_sitemaps"
    raw_dir.mkdir(parents=True, exist_ok=True)
    return output_dir, raw_dir


def write_inventory_csv(rows: list[dict[str, str]], output_file: Path) -> None:
    fieldnames = [
        "url",
        "path",
        "content_type",
        "source_sitemap",
        "lastmod",
        "suspected_test_page",
        "has_uppercase_path",
        "potential_duplicate_group",
    ]
    with output_file.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def write_redirect_seed_csv(rows: list[dict[str, str]], output_file: Path) -> None:
    fieldnames = ["old_url", "new_url", "status", "note"]
    with output_file.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def write_summary_md(
    *,
    output_file: Path,
    sitemap_index: str,
    generated_at: str,
    row_count: int,
    unique_url_count: int,
    counts_by_type: Counter[str],
    counts_by_sitemap: Counter[str],
    suspicious_pages: list[str],
    uppercase_urls: list[str],
    duplicate_groups: dict[str, list[str]],
) -> None:
    lines: list[str] = []
    lines.append("# Academy Sitemap Audit")
    lines.append("")
    lines.append(f"- Generated at: `{generated_at}`")
    lines.append(f"- Sitemap index: `{sitemap_index}`")
    lines.append(f"- Total URLs: `{row_count}`")
    lines.append(f"- Unique URLs: `{unique_url_count}`")
    lines.append("")
    lines.append("## Count by content type")
    lines.append("")
    for content_type, count in sorted(counts_by_type.items()):
        lines.append(f"- {content_type}: `{count}`")
    lines.append("")
    lines.append("## Count by source sitemap")
    lines.append("")
    for source, count in sorted(counts_by_sitemap.items()):
        lines.append(f"- {source}: `{count}`")
    lines.append("")
    lines.append("## Potential SEO risks")
    lines.append("")
    if duplicate_groups:
        lines.append(f"- Duplicate normalized path groups: `{len(duplicate_groups)}`")
    else:
        lines.append("- Duplicate normalized path groups: `0`")
    lines.append(f"- Suspected test/technical pages: `{len(suspicious_pages)}`")
    lines.append(f"- URLs with uppercase path segments: `{len(uppercase_urls)}`")
    lines.append("")
    lines.append("## Suspected test/technical pages")
    lines.append("")
    if suspicious_pages:
        for url in suspicious_pages:
            lines.append(f"- {url}")
    else:
        lines.append("- None detected")
    lines.append("")
    lines.append("## Uppercase path URLs")
    lines.append("")
    if uppercase_urls:
        for url in uppercase_urls:
            lines.append(f"- {url}")
    else:
        lines.append("- None detected")
    lines.append("")
    lines.append("## Duplicate normalized path groups")
    lines.append("")
    if duplicate_groups:
        for key, urls in sorted(duplicate_groups.items()):
            lines.append(f"- `{key}`")
            for url in sorted(urls):
                lines.append(f"  - {url}")
    else:
        lines.append("- None detected")
    lines.append("")
    output_file.write_text("\n".join(lines), encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description="Generate sitemap audit files for migration planning.")
    parser.add_argument("--sitemap-index", default=DEFAULT_SITEMAP_INDEX, help="Sitemap index URL")
    parser.add_argument("--output-dir", default="audit", help="Output directory for audit files")
    parser.add_argument(
        "--verify-ssl",
        action="store_true",
        help="Enable strict SSL certificate verification (disabled by default for compatibility)",
    )
    args = parser.parse_args()

    output_dir = Path(args.output_dir)
    output_dir, raw_dir = ensure_output_dirs(output_dir)
    generated_at = dt.datetime.now(dt.UTC).replace(microsecond=0).isoformat()

    index_bytes = fetch_url(args.sitemap_index, verify_ssl=args.verify_ssl)
    (raw_dir / "sitemap_index.xml").write_bytes(index_bytes)
    sitemap_urls = parse_sitemap_index(index_bytes)
    if not sitemap_urls:
        raise RuntimeError(f"No sitemap URLs found in index: {args.sitemap_index}")

    inventory_rows: list[dict[str, str]] = []
    counts_by_type: Counter[str] = Counter()
    counts_by_sitemap: Counter[str] = Counter()

    for sitemap_url in sitemap_urls:
        sitemap_name = Path(urllib.parse.urlparse(sitemap_url).path).name or "unknown-sitemap.xml"
        sitemap_bytes = fetch_url(sitemap_url, verify_ssl=args.verify_ssl)
        (raw_dir / sitemap_name).write_bytes(sitemap_bytes)
        url_rows = parse_urlset(sitemap_bytes)

        for url_row in url_rows:
            url = url_row["url"]
            path = path_from_url(url)
            content_type = detect_content_type(sitemap_name)
            normalized_key = normalized_path_key(path)
            has_uppercase = has_uppercase_path(path)
            suspected_test_page = is_suspected_test_page(path)

            inventory_rows.append(
                {
                    "url": url,
                    "path": path,
                    "content_type": content_type,
                    "source_sitemap": sitemap_name,
                    "lastmod": url_row.get("lastmod", ""),
                    "suspected_test_page": "yes" if suspected_test_page else "no",
                    "has_uppercase_path": "yes" if has_uppercase else "no",
                    "potential_duplicate_group": normalized_key,
                }
            )
            counts_by_type[content_type] += 1
            counts_by_sitemap[sitemap_name] += 1

    unique_urls = set(row["url"] for row in inventory_rows)
    groups: dict[str, list[str]] = defaultdict(list)
    for row in inventory_rows:
        groups[row["potential_duplicate_group"]].append(row["url"])
    duplicate_groups = {key: sorted(set(urls)) for key, urls in groups.items() if len(set(urls)) > 1}

    suspicious_pages = sorted(
        {
            row["url"]
            for row in inventory_rows
            if row["suspected_test_page"] == "yes"
        }
    )
    uppercase_urls = sorted(
        {
            row["url"]
            for row in inventory_rows
            if row["has_uppercase_path"] == "yes"
        }
    )

    write_inventory_csv(inventory_rows, output_dir / "urls_inventory.csv")

    redirect_seed_rows: list[dict[str, str]] = []
    for row in inventory_rows:
        old_url = row["url"]
        path = row["path"].lower().rstrip("/") or "/"
        suggested_new_url = ""
        status = ""
        note = ""

        if path.endswith("/home"):
            suggested_new_url = old_url.replace("/home/", "/")
            status = "301"
            note = "Candidate consolidation to main language root."
        elif row["suspected_test_page"] == "yes":
            status = "review"
            note = "Likely test/technical page. Consider noindex or removal."

        if suggested_new_url or status:
            redirect_seed_rows.append(
                {
                    "old_url": old_url,
                    "new_url": suggested_new_url,
                    "status": status,
                    "note": note,
                }
            )

    write_redirect_seed_csv(redirect_seed_rows, output_dir / "redirect_seed.csv")
    write_summary_md(
        output_file=output_dir / "summary.md",
        sitemap_index=args.sitemap_index,
        generated_at=generated_at,
        row_count=len(inventory_rows),
        unique_url_count=len(unique_urls),
        counts_by_type=counts_by_type,
        counts_by_sitemap=counts_by_sitemap,
        suspicious_pages=suspicious_pages,
        uppercase_urls=uppercase_urls,
        duplicate_groups=duplicate_groups,
    )

    print(f"Audit files written to: {output_dir.resolve()}")
    print(f"- urls_inventory.csv ({len(inventory_rows)} rows)")
    print(f"- summary.md")
    print(f"- redirect_seed.csv ({len(redirect_seed_rows)} rows)")
    print(f"- raw_sitemaps/*.xml ({len(sitemap_urls) + 1} files)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
