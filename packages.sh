#!/bin/sh

set -ouex pipefail

EXCLUDED_PACKAGES=($(jq -r ".exclude | sort | unique[]" /packages.json))
INCLUDED_PACKAGES=($(jq -r ".include | sort | unique[]" /packages.json))

if [[ "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
  dnf5 -y remove "${EXCLUDED_PACKAGES[@]}"
else
  echo "No packages to remove."
fi

if [[ "${#INCLUDED_PACKAGES[@]}" -gt 0 ]]; then
  dnf5 -y install "${INCLUDED_PACKAGES[@]}"
else
  echo "No packages to install."
fi
