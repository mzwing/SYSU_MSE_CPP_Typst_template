#!/usr/bin/env bash

set -euo pipefail

force=0

while (($# > 0)); do
  case "$1" in
    --force|-f)
      force=1
      shift
      ;;
    --help|-h)
      cat <<EOF
Usage: $0 [--force] [namespace] [package_name] [package_version] [data_dir]
EOF
      exit 0
      ;;
    *)
      break
      ;;
  esac
done

namespace="${1:-local}"
package_name="${2:-sysu-mse-cpp-template}"
package_version="${3:-0.1.0}"
data_root="${4:-}"

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

validate_path_segment() {
  local label="$1"
  local value="$2"

  if [[ -z "$value" ]]; then
    echo "Error: ${label} must not be empty." >&2
    exit 1
  fi

  if [[ "$value" == *"/"* || "$value" == *"\\"* || "$value" == "." || "$value" == ".." ]]; then
    echo "Error: invalid ${label} '${value}'. Use a single path segment without '/' '\\' '.' or '..'." >&2
    exit 1
  fi
}

validate_path_segment "namespace" "$namespace"
validate_path_segment "package name" "$package_name"
validate_path_segment "package version" "$package_version"

if [[ -z "$data_root" ]]; then
  if [[ "${OSTYPE:-}" == darwin* ]]; then
    data_root="${HOME}/Library/Application Support"
  else
    data_root="${XDG_DATA_HOME:-${HOME}/.local/share}"
  fi
fi

packages_root="${data_root}/typst/packages"
target_dir="${packages_root}/${namespace}/${package_name}"
target_link="${target_dir}/${package_version}"

case "$target_link" in
  "$packages_root"/*) ;;
  *)
    echo "Error: refusing to operate outside Typst packages directory: $target_link" >&2
    exit 1
    ;;
esac

mkdir -p "$target_dir"

if [[ -L "$target_link" ]]; then
  existing_target="$(readlink "$target_link" || true)"

  if [[ "$existing_target" == "$repo_root" ]]; then
    rm -f "$target_link"
  elif [[ "$force" -eq 1 ]]; then
    rm -rf "$target_link"
  else
    echo "Error: target already exists as a symlink to '$existing_target'." >&2
    echo "Refusing to replace it without --force." >&2
    exit 1
  fi
elif [[ -e "$target_link" ]]; then
  if [[ "$force" -eq 1 ]]; then
    rm -rf "$target_link"
  else
    echo "Error: target already exists and is not a symlink managed by this installer: $target_link" >&2
    echo "Refusing to remove it without --force." >&2
    exit 1
  fi
fi

ln -s "$repo_root" "$target_link"

cat <<EOF
Installed local Typst package:
  source: $repo_root
  target: $target_link

Import it in any Typst project with:
  #import "@${namespace}/${package_name}:${package_version}": report, lab-table
EOF
