#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

clear
echo ""
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   🤖 OpenClaw - Discord Bot + OpenRouter FREE${NC}"
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo ""

# Check secrets
MISSING=0

if [ -z "$OPENROUTER_API_KEY" ]; then
    echo -e "${RED}❌ OPENROUTER_API_KEY not found!${NC}"
    MISSING=1
fi

if [ -z "$DISCORD_BOT_TOKEN" ]; then
    echo -e "${RED}❌ DISCORD_BOT_TOKEN not found!${NC}"
    MISSING=1
fi

if [ -z "$GATEWAY_TOKEN" ]; then
    echo -e "${YELLOW}⚠️  GATEWAY_TOKEN not set, using 'changeme'${NC}"
    export GATEWAY_TOKEN="changeme"
fi

if [ $MISSING -eq 1 ]; then
    echo ""
    echo -e "${YELLOW}Please add secrets in GitHub:${NC}"
    echo "Repository → Settings → Secrets → Codespaces"
    echo ""
    exit 1
fi

echo -e "${GREEN}✓ All secrets loaded from GitHub!${NC}"
echo ""
echo -e "${YELLOW}Configuration:${NC}"
echo "  🤖 AI Provider  : OpenRouter"
echo "  🆓 Model        : FREE (auto-select)"
echo "  💬 Messaging    : Discord"
echo "  🌐 Port         : 18789"
echo ""

# Show Gateway URL
if [ ! -z "$CODESPACE_NAME" ]; then
    echo -e "${GREEN}═══════════════════════════════════════════════${NC}"
    echo -e "${GREEN}📡 Gateway URL:${NC}"
    echo -e "${BLUE}https://${CODESPACE_NAME}-18789.app.github.dev${NC}"
    echo ""
    echo -e "${YELLOW}Add ?token=${GATEWAY_TOKEN} to access${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════${NC}"
    echo ""
fi

# Start OpenClaw
echo -e "${YELLOW}Starting OpenClaw Gateway...${NC}"
echo ""

npx openclaw gateway start \
    --config ~/.openclaw/config.json \
    --port 18789 \
    --host 0.0.0.0
