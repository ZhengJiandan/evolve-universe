# zerobot-universe

Public Universe services for zerobot. This repo hosts both the **registry** (node directory)
and the **relay** (privacy-preserving task forwarding).

## Relationship to zerobot

This repository provides the standalone **registry** and **relay** services used by the
AI Universe feature in the main zerobot project.

zerobot GitHub: `https://github.com/ZhengJiandan/zerobot`

## Install

```bash
pip install -e .
```

## Run

Registry (foreground):

```bash
zerobot-universe-registry run --host 0.0.0.0 --port 18999 --foreground
```

Relay (foreground):

```bash
zerobot-universe-relay run --host 0.0.0.0 --port 19001 --foreground
```

Background mode is the default if you omit `--foreground`.
Logs are written to `~/.zerobot/registry.log` and `~/.zerobot/relay.log`.

## One-click start (registry + relay)

```bash
./scripts/start_all.sh
```

Environment overrides:

```bash
REGISTRY_HOST=0.0.0.0 REGISTRY_PORT=18999 RELAY_HOST=0.0.0.0 RELAY_PORT=19001 ./scripts/start_all.sh
```

## Registry bridge

```bash
zerobot-universe-registry-bridge \
  --registry ws://reg1:18999 \
  --registry ws://reg2:18999 \
  --interval 15
```
