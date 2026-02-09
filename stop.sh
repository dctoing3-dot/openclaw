#!/bin/bash

echo "🛑 Stopping OpenClaw..."
pkill -f "openclaw" 2>/dev/null
pkill -f "node" 2>/dev/null

echo "✅ OpenClaw stopped"
