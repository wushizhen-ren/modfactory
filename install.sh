#!/usr/bin/env bash
set -euo pipefail

# ModFactory v3.1 — macOS / Linux One-Click Install
echo "========================================"
echo " ModFactory v3.1 — One-Click Install"
echo "========================================"
echo ""

# ---------------------------------------------------------------------------
# 0. Prerequisites check
# ---------------------------------------------------------------------------
echo "[0/5] Checking prerequisites..."

missing=()

command -v git >/dev/null 2>&1 || missing+=("git")
command -v node >/dev/null 2>&1 || missing+=("node")
command -v npm >/dev/null 2>&1  || missing+=("npm")

if command -v java >/dev/null 2>&1; then
    java_version=$(java -version 2>&1 | head -1 | grep -oE '[0-9]+' | head -1 || echo "0")
    if [ "$java_version" -lt 21 ]; then
        echo "  [WARN] Java $java_version detected. Java 21+ is recommended for Minecraft 1.21.1."
    else
        echo "  [OK] Java $java_version"
    fi
else
    echo "  [WARN] Java not found. Minecraft 1.21.1 requires Java 21+."
fi

if [ ${#missing[@]} -gt 0 ]; then
    echo "  [WARN] Missing: ${missing[*]}"
    echo "  Install with: brew install ${missing[*]}"
else
    echo "  [OK] git, node, npm found"
fi

# PowerShell (pwsh) check — needed for texture engine scripts
if command -v pwsh >/dev/null 2>&1; then
    echo "  [OK] PowerShell (pwsh) found"
else
    echo "  [INFO] PowerShell (pwsh) not found — texture engine needs it"
    echo "  Install with: brew install powershell"
fi

echo ""

# ---------------------------------------------------------------------------
# 1. Install MCP packages
# ---------------------------------------------------------------------------
echo "[1/5] Installing mcdev-mcp (Minecraft source access)..."
if npm install -g @mcdxai/minecraft-dev-mcp 2>/dev/null; then
    echo "  [OK] mcdev-mcp installed"
else
    echo "  [SKIP] npm not available — mcdev-mcp skipped"
fi

echo "[2/5] Installing mcmodding-mcp (Fabric docs)..."
if npm install -g mcmodding-mcp 2>/dev/null; then
    echo "  [OK] mcmodding-mcp installed"
else
    echo "  [SKIP] npm not available — mcmodding-mcp skipped"
fi

# ---------------------------------------------------------------------------
# 3. Clone GearFactory engine
# ---------------------------------------------------------------------------
echo "[3/5] Installing GearFactory engine..."
if [ -d "forge_engine" ]; then
    echo "  [OK] GearFactory already present"
else
    echo "  [INFO] Clone from https://github.com/buyicoder/GearFactory"
    if git clone https://github.com/buyicoder/GearFactory.git forge_engine 2>/dev/null; then
        echo "  [OK] GearFactory installed"
    else
        echo "  [SKIP] git not available — install manually"
    fi
fi

# ---------------------------------------------------------------------------
# 4. Configure MCP servers for Claude Code
# ---------------------------------------------------------------------------
echo "[4/5] Configuring MCP servers..."
mkdir -p .claude

MCP_CONFIG=".claude/settings.local.json"
if [ -f "$MCP_CONFIG" ]; then
    echo "  [SKIP] $MCP_CONFIG already exists"
else
    cat > "$MCP_CONFIG" << 'MCPEOF'
{
  "mcpServers": {
    "minecraft-dev": {
      "command": "npx",
      "args": ["-y", "@mcdxai/minecraft-dev-mcp"]
    },
    "mcmodding": {
      "command": "npx",
      "args": ["-y", "mcmodding-mcp"]
    }
  }
}
MCPEOF
    echo "  [OK] MCP config created at $MCP_CONFIG"
fi

# ---------------------------------------------------------------------------
# 5. Verify fabric-mod-dev builds (smoke test)
# ---------------------------------------------------------------------------
echo "[5/5] Verifying fabric-mod-dev project..."
if [ -f "fabric-mod-dev/gradlew" ]; then
    chmod +x fabric-mod-dev/gradlew
    echo "  [INFO] Running ./gradlew build in fabric-mod-dev/..."
    if (cd fabric-mod-dev && ./gradlew build --no-daemon 2>&1 | tail -3); then
        echo "  [OK] fabric-mod-dev builds successfully"
    else
        echo "  [WARN] Build failed — check Java version or network"
    fi
else
    echo "  [SKIP] fabric-mod-dev/gradlew not found (may need manual setup)"
fi

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
echo ""
echo "========================================"
echo " Install Complete!"
echo "========================================"
echo ""
echo " ModFactory skills: 25 (auto-loaded)"
echo " MCP servers: mcdev-mcp + mcmodding-mcp"
echo " GearFactory: texture engine"
echo " Architecture: 5 patterns from classic mods"
echo ""
echo " Quick start:"
echo "   cd fabric-mod-dev && ./gradlew runClient"
echo ""
echo " macOS tips:"
echo "   - Install PowerShell for texture engine: brew install powershell"
echo "   - Install Blockbench: brew install --cask blockbench"
echo "   - Blockbench path: /Applications/Blockbench.app"
echo ""
