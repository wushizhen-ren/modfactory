#!/usr/bin/env bash
set -euo pipefail

# ModFactory — Setup: minecraft-ai texture generator (macOS / Linux)
echo "========================================"
echo " Setup: minecraft-ai texture generator"
echo "========================================"
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Step 1: Clone minecraft-ai
if [ ! -d "minecraft-ai" ]; then
    echo "[1/3] Cloning minecraft-ai..."
    if git clone https://github.com/Jhon-crypt/minecraft-ai.git; then
        :
    else
        echo "[FAIL] Could not clone. Install git or download manually."
        exit 1
    fi
else
    echo "[1/3] minecraft-ai already exists"
fi

# Step 2: Install Python dependencies
echo "[2/3] Installing Python dependencies..."
if pip install torch torchvision pillow numpy; then
    :
else
    echo "[WARN] pip install failed. Try: pip install torch torchvision pillow numpy"
fi

# Step 3: Verify
echo "[3/3] Verifying setup..."
if python -c "from src.minecraft_ai_generator.texture_generator import generate_texture; print('minecraft-ai ready!')" 2>/dev/null; then
    echo "[OK] minecraft-ai is ready!"
else
    echo "[WARN] Import test failed — check torch installation"
fi

echo ""
echo "========================================"
echo " Setup complete!"
echo ""
echo " Usage: python -c \"from src.minecraft_ai_generator.texture_generator import generate_texture; generate_texture('your prompt here')\""
echo "========================================"
