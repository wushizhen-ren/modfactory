#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLIENT_DIR="$ROOT_DIR/fabric-mod-dev"

usage() {
  printf 'Usage: %s {setup|build|run}\n' "$0"
}

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'Missing required command: %s\n' "$1" >&2
    exit 1
  fi
}

check_java() {
  require_command java
  java_major="$(java -version 2>&1 | awk -F '[\".]' '/version/ {print $2; exit}')"
  if [[ "$java_major" != "21" ]]; then
    printf 'Java 21 is required; found Java %s.\n' "${java_major:-unknown}" >&2
    exit 1
  fi
}

setup() {
  check_java
  require_command git
  require_command npm
  chmod +x "$CLIENT_DIR/gradlew"

  if ! command -v minecraft-dev-cli >/dev/null 2>&1; then
    npm install -g @mcdxai/minecraft-dev-mcp
  fi

  if [[ ! -d "$ROOT_DIR/forge_engine" ]]; then
    git clone --depth 1 https://github.com/buyicoder/GearFactory.git "$ROOT_DIR/forge_engine"
  fi

  printf 'ModFactory macOS development environment is ready.\n'
}

case "${1:-}" in
  setup)
    setup
    ;;
  build)
    check_java
    cd "$CLIENT_DIR"
    ./gradlew build
    ;;
  run)
    check_java
    cd "$CLIENT_DIR"
    ./gradlew runClient
    ;;
  *)
    usage
    exit 2
    ;;
esac

