#!/bin/bash

# Flutter Autonomous Development Template - Setup Script

set -e

echo "🚀 Setting up Flutter Autonomous Development Template..."
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check Flutter
echo "📱 Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter not found. Please install Flutter first.${NC}"
    echo "   https://docs.flutter.dev/get-started/install"
    exit 1
fi
flutter --version
echo ""

# Check Dart
echo "🎯 Checking Dart installation..."
dart --version
echo ""

# Install Flutter dependencies
echo "📦 Installing Flutter dependencies..."
flutter pub get
echo ""

# Make hook scripts executable
echo "🔧 Setting up hooks..."
chmod +x .claude/hooks/*.sh 2>/dev/null || true
echo -e "${GREEN}✅ Hooks configured${NC}"
echo ""

# Initialize git if needed
if [ ! -d ".git" ]; then
    echo "📚 Initializing git repository..."
    git init
    echo -e "${GREEN}✅ Git initialized${NC}"
else
    echo -e "${GREEN}✅ Git already initialized${NC}"
fi
echo ""

# Run initial analysis
echo "🔍 Running initial analysis..."
dart analyze lib/ || true
echo ""

# Check optional tools
echo "🔎 Checking optional tools..."

if command -v maestro &> /dev/null; then
    echo -e "${GREEN}✅ Maestro CLI found${NC}"
    maestro --version
else
    echo -e "${YELLOW}⚠️  Maestro CLI not found (optional, needed for E2E testing)${NC}"
    echo "   Install: curl -fsSL \"https://get.maestro.mobile.dev\" | bash"
fi

if command -v gemini &> /dev/null; then
    echo -e "${GREEN}✅ Gemini CLI found${NC}"
else
    echo -e "${YELLOW}⚠️  Gemini CLI not found (optional, needed for self-review)${NC}"
    echo "   Install: npm install -g @google/gemini-cli"
fi

if command -v claude &> /dev/null; then
    echo -e "${GREEN}✅ Claude Code CLI found${NC}"
else
    echo -e "${YELLOW}⚠️  Claude Code CLI not found${NC}"
    echo "   Install: npm install -g @anthropic-ai/claude-code"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✨ Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Start Claude Code: claude"
echo "  2. Run: /start-development"
echo "  3. Answer requirement questions"
echo "  4. Let Claude Code build your app!"
echo ""
echo "Documentation:"
echo "  - README.md - Overview"
echo "  - docs/SETUP.md - Detailed setup guide"
echo "  - docs/WORKFLOW.md - Development workflow"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
