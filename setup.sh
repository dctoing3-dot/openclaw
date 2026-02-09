#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   🤖 OpenClaw Setup - Discord + OpenRouter${NC}"
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo ""

# Step 1: Install pnpm
echo -e "${YELLOW}[1/5] Installing pnpm...${NC}"
npm install -g pnpm

# Step 2: Install dependencies
echo -e "${YELLOW}[2/5] Installing dependencies...${NC}"
pnpm install

# Step 3: Build
echo -e "${YELLOW}[3/5] Building OpenClaw...${NC}"
pnpm ui:build 2>/dev/null || echo "UI build skipped"
pnpm build 2>/dev/null || echo "Build skipped"

# Step 4: Create directories
echo -e "${YELLOW}[4/5] Creating directories...${NC}"
mkdir -p ~/.openclaw
mkdir -p logs

# Step 5: Create config from GitHub Secrets
echo -e "${YELLOW}[5/5] Creating configuration...${NC}"

cat > ~/.openclaw/config.json << EOF
{
  "ai": {
    "provider": "openrouter",
    "openrouter": {
      "apiKey": "${OPENROUTER_API_KEY}",
      "model": "openrouter/free",
      "baseURL": "https://openrouter.ai/api/v1",
      "maxTokens": 4096
    }
  },
  "gateway": {
    "port": 18789,
    "host": "0.0.0.0",
    "token": "${GATEWAY_TOKEN:-changeme}"
  },
  "messaging": {
    "discord": {
      "enabled": true,
      "token": "${DISCORD_BOT_TOKEN}",
      "guildId": "${DISCORD_GUILD_ID}",
      "prefix": "!"
    }
  }
}
EOF

# Make scripts executable
chmod +x start.sh stop.sh 2>/dev/null || true

echo ""
echo -e "${GREEN}════════════════════════════════════════════════${NC}"
echo -e "${GREEN}   ✅ Setup Complete!${NC}"
echo -e "${GREEN}════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Configuration:${NC}"
echo "  AI Provider : OpenRouter (FREE models)"
echo "  Model       : openrouter/free (auto-select)"
echo "  Messaging   : Discord"
echo "  Port        : 18789"
echo ""
echo -e "${GREEN}Next: Run ${BLUE}./start.sh${GREEN} to start OpenClaw${NC}"
echo ""
