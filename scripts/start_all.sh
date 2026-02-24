#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

PYTHON_BIN="${PYTHON_BIN:-python3}"
export PYTHONPATH="${REPO_ROOT}/src${PYTHONPATH:+:${PYTHONPATH}}"

REGISTRY_HOST="${REGISTRY_HOST:-0.0.0.0}"
REGISTRY_PORT="${REGISTRY_PORT:-18999}"
REGISTRY_TOKEN="${REGISTRY_TOKEN:-}"
REGISTRY_LOG="${REGISTRY_LOG:-${SCRIPT_DIR}/registry.log}"

RELAY_HOST="${RELAY_HOST:-0.0.0.0}"
RELAY_PORT="${RELAY_PORT:-19001}"
RELAY_TOKEN="${RELAY_TOKEN:-}"
RELAY_LOG="${RELAY_LOG:-${SCRIPT_DIR}/relay.log}"

REGISTRY_ARGS=("--foreground" "--host" "$REGISTRY_HOST" "--port" "$REGISTRY_PORT")
if [[ -n "$REGISTRY_TOKEN" ]]; then
  REGISTRY_ARGS+=("--token" "$REGISTRY_TOKEN")
fi

RELAY_ARGS=("--foreground" "--host" "$RELAY_HOST" "--port" "$RELAY_PORT")
if [[ -n "$RELAY_TOKEN" ]]; then
  RELAY_ARGS+=("--token" "$RELAY_TOKEN")
fi

nohup "$PYTHON_BIN" -m evolvebot_universe.registry_cli run "${REGISTRY_ARGS[@]}" >"$REGISTRY_LOG" 2>&1 &
REG_PID=$!

nohup "$PYTHON_BIN" -m evolvebot_universe.relay_cli run "${RELAY_ARGS[@]}" >"$RELAY_LOG" 2>&1 &
RELAY_PID=$!

echo "Registry started (pid=${REG_PID})"
echo "Registry logs: ${REGISTRY_LOG}"
echo "Relay started (pid=${RELAY_PID})"
echo "Relay logs: ${RELAY_LOG}"
