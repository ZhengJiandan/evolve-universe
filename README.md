# evolvebot-universe

Public Universe services for evolvebot. This repo hosts both the **registry** (node directory)
and the **relay** (privacy-preserving task forwarding).

## Relationship to evolvebot

This repository provides the standalone **registry** and **relay** services used by the
AI Universe feature in the main evolvebot project.

evolvebot GitHub: `https://github.com/ZhengJiandan/evolvebot`

## Install

```bash
pip install -e .
```

## Run

Registry (foreground):

```bash
evolvebot-universe-registry run --host 0.0.0.0 --port 18999 --foreground
```

Relay (foreground):

```bash
evolvebot-universe-relay run --host 0.0.0.0 --port 19001 --foreground
```

Background mode is the default if you omit `--foreground`.
Logs are written to `~/.evolvebot/registry.log` and `~/.evolvebot/relay.log`.

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
evolvebot-universe-registry-bridge \
  --registry ws://reg1:18999 \
  --registry ws://reg2:18999 \
  --interval 15
```