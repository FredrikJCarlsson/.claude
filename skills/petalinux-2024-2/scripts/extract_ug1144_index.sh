#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <ug1144.pdf> [output-file]"
  exit 1
fi

pdf_path="$1"
out_file="${2:-/tmp/ug1144-command-index.txt}"

if [[ ! -f "$pdf_path" ]]; then
  echo "PDF not found: $pdf_path"
  exit 1
fi

if ! command -v strings >/dev/null 2>&1; then
  echo "Missing required command: strings"
  exit 1
fi

if ! command -v rg >/dev/null 2>&1; then
  echo "Missing required command: rg"
  exit 1
fi

tmp_file="$(mktemp)"
trap 'rm -f "$tmp_file"' EXIT

strings -n 8 "$pdf_path" >"$tmp_file"

{
  echo "# UG1144 command sections"
  echo "# Source: $pdf_path"
  echo
  rg -n "/Title \\(petalinux-[^)]+\\)" "$tmp_file" \
    | sed -E 's@^[0-9]+:/Title \((.*)\)$@- \1@'
} >"$out_file"

echo "Wrote command index to: $out_file"
