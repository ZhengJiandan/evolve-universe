#!/usr/bin/env bash
set -euo pipefail

REGISTRY_HOST="${REGISTRY_HOST:-0.0.0.0}"
REGISTRY_PORT="${REGISTRY_PORT:-18999}"
REGISTRY_TOKEN="${REGISTRY_TOKEN:-}"

RELAY_HOST="${RELAY_HOST:-0.0.0.0}"
RELAY_PORT="${RELAY_PORT:-19001}"
RELAY_TOKEN="${RELAY_TOKEN:-}"

REGISTRY_ARGS=("--foreground" "--host" "$REGISTRY_HOST" "--port" "$REGISTRY_PORT")
if [[ -n "$REGISTRY_TOKEN" ]]; then
  REGISTRY_ARGS+=("--token" "$REGISTRY_TOKEN")
fi

RELAY_ARGS=("--foreground" "--host" "$RELAY_HOST" "--port" "$RELAY_PORT")
if [[ -n "$RELAY_TOKEN" ]]; then
  RELAY_ARGS+=("--token" "$RELAY_TOKEN")
fi

zerobot-universe-registry "${REGISTRY_ARGS[@]}" &
REG_PID=$!

zerobot-universe-relay "${RELAY_ARGS[@]}" &
RELAY_PID=$!

cleanup() {
  kill "$REG_PID" "$RELAY_PID" 2>/dev/null || true
}
trap cleanup EXIT

wait -n "$REG_PID" "$RELAY_PID"
