#!/usr/bin/env bash
##
##  Generate XiaoClaw bootstrap archives using pre-built packages from
##  the Termux apt repository. Much faster than build-xiaoclaw-bootstrap.sh
##  which compiles everything from source (~3h vs ~5min).
##
##  Usage:
##    ./scripts/generate-xiaoclaw-bootstrap.sh [--architectures aarch64]
##

set -e

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# XiaoClaw additional packages to include in the bootstrap.
XIAOCLAW_PACKAGES=(
    "nodejs-lts"      # Node.js LTS runtime
    "npm"             # npm package manager
    "git"             # Git version control
    "openssh"         # SSH client and server
    "openssl"         # OpenSSL tools
    "termux-api"      # Termux:API interface
    "proot"           # proot for /tmp support via termux-chroot
    "expect"          # expect for automated password setup
    "android-tools"   # adb/fastboot for wireless ADB fallback
)

# Convert array to comma-separated list
XIAOCLAW_PACKAGES_CSV=$(IFS=,; echo "${XIAOCLAW_PACKAGES[*]}")

echo "========================================"
echo "  XiaoClaw Bootstrap Generator (fast mode)"
echo "========================================"
echo ""
echo "Additional packages to include:"
for pkg in "${XIAOCLAW_PACKAGES[@]}"; do
    echo "  - ${pkg}"
done
echo ""
echo "Using pre-built packages from Termux apt repo"
echo "========================================"

# Run generate-bootstraps.sh with XiaoClaw packages.
exec "${SCRIPT_DIR}/generate-bootstraps.sh" \
    --add "${XIAOCLAW_PACKAGES_CSV}" \
    "$@"
