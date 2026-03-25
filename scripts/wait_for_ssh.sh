#!/usr/bin/env bash
# Polls the target server until SSH is reachable so Ansible can connect safely after provisioning.
set -euo pipefail

TARGET_HOST="${1:?Usage: wait_for_ssh.sh <ip-address> [ssh-user] [private-key-path] [timeout-seconds]}"
TARGET_USER="${2:-root}"
PRIVATE_KEY_PATH="${3:-}"
TIMEOUT_SECONDS="${4:-300}"
START_TIME="$(date +%s)"

SSH_OPTS=(
  -o BatchMode=yes
  -o StrictHostKeyChecking=no
  -o UserKnownHostsFile=/dev/null
  -o ConnectTimeout=5
)

if [ -n "${PRIVATE_KEY_PATH}" ]; then
  SSH_OPTS+=(-i "${PRIVATE_KEY_PATH}")
fi

until ssh "${SSH_OPTS[@]}" "${TARGET_USER}@${TARGET_HOST}" "exit" 2>/dev/null; do
  NOW="$(date +%s)"
  ELAPSED="$((NOW - START_TIME))"

  if [ "${ELAPSED}" -ge "${TIMEOUT_SECONDS}" ]; then
    echo "Timed out waiting for SSH on ${TARGET_USER}@${TARGET_HOST}" >&2
    exit 1
  fi

  sleep 5
done

echo "SSH is available on ${TARGET_USER}@${TARGET_HOST}"
