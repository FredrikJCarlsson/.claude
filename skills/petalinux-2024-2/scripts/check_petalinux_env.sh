#!/usr/bin/env bash
set -euo pipefail

commands=(
  petalinux-create
  petalinux-config
  petalinux-build
  petalinux-boot
  petalinux-package
  petalinux-util
  petalinux-upgrade
  petalinux-devtool
)

echo "PetaLinux environment check"
echo "PWD: $(pwd)"
echo

if [[ -n "${PETALINUX:-}" ]]; then
  echo "PETALINUX is set: $PETALINUX"
else
  echo "PETALINUX is not set"
fi

echo
missing=0
for cmd in "${commands[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "[OK] $cmd -> $(command -v "$cmd")"
  else
    echo "[MISSING] $cmd"
    missing=1
  fi
done

echo
if [[ $missing -eq 0 ]]; then
  echo "All core petalinux commands are present."
else
  echo "Some commands are missing. Source the PetaLinux settings script and retry."
  exit 2
fi
