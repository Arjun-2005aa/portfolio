#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"$ROOT_DIR/scripts/package-site.sh"
rm -rf "$ROOT_DIR/docs"
ditto "$ROOT_DIR/deploy" "$ROOT_DIR/docs"
touch "$ROOT_DIR/docs/.nojekyll"

printf 'GitHub Pages folder ready at %s\n' "$ROOT_DIR/docs"
