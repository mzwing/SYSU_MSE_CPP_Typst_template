#!/usr/bin/env bash

set -euo pipefail

namespace="${1:-local}"
package_name="${2:-sysu-mse-cpp-template}"
package_version="${3:-0.1.0}"
data_root="${4:-}"

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -z "$data_root" ]]; then
  if [[ "${OSTYPE:-}" == darwin* ]]; then
    data_root="${HOME}/Library/Application Support"
  else
    data_root="${XDG_DATA_HOME:-${HOME}/.local/share}"
  fi
fi

target_dir="${data_root}/typst/packages/${namespace}/${package_name}"
target_link="${target_dir}/${package_version}"

mkdir -p "$target_dir"

if [[ -L "$target_link" || -e "$target_link" ]]; then
  rm -rf "$target_link"
fi

ln -s "$repo_root" "$target_link"

cat <<EOF
Installed local Typst package:
  source: $repo_root
  target: $target_link

Import it in any Typst project with:
  #import "@${namespace}/${package_name}:${package_version}": report, lab-table
EOF
