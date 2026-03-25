#!/usr/bin/env bash
# Renders a minimal Ansible inventory from the Terraform-created host IP for CI/CD runs.
set -euo pipefail

TARGET_HOST="${1:?Usage: render_inventory.sh <ip-address>}"
TARGET_USER="${2:-root}"

cat <<EOF
all:
  children:
    linux:
      hosts:
        web-lss:
          ansible_host: ${TARGET_HOST}
          ansible_user: ${TARGET_USER}
EOF
