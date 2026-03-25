#!/usr/bin/env bash
# Polls the target server until SSH is reachable so Ansible can connect safely after provisioning.
set -euo pipefail

TARGET_HOST="${1:?Usage: wait_for_ssh.sh <ip-address> [timeout-seconds]}"
TIMEOUT_SECONDS="${2:-300}"
START_TIME="$(date +%s)"

until ssh -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=5 "root@${TARGET_HOST}" "exit" 2>/dev/null; do
  NOW="$(date +%s)"
  ELAPSED="$((NOW - START_TIME))"

  if [ "${ELAPSED}" -ge "${TIMEOUT_SECONDS}" ]; then
    echo "Timed out waiting for SSH on ${TARGET_HOST}" >&2
    exit 1
  fi

  sleep 5
done

echo "SSH is available on ${TARGET_HOST}"
