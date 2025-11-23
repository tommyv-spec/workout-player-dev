#!/bin/bash
# ════════════════════════════════════════════════════════════════════════════
# VILTRUM FITNESS V6 - PATH CORRECTION SCRIPT
# Fixes all file paths for /pages/ folder structure
# ════════════════════════════════════════════════════════════════════════════

echo "🔧 Viltrum Fitness V6 - Path Correction Script"
echo "════════════════════════════════════════════════"
echo ""

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if we're in the right directory
if [ ! -f "index.html" ] || [ ! -d "pages" ]; then
    echo -e "${RED}❌ Error: Please run this script from your project root directory${NC}"
    echo "   (The directory containing index.html and /pages/ folder)"
    exit 1
fi

echo -e "${GREEN}✓ Project structure found${NC}"
echo ""

# Backup files
echo "📦 Creating backups..."
mkdir -p .backups
cp index.html .backups/index.html.bak 2>/dev/null
cp pages/dashboard.html .backups/dashboard.html.bak 2>/dev/null
cp pages/workout.html .backups/workout.html.bak 2>/dev/null
cp pages/nutrition.html .backups/nutrition.html.bak 2>/dev/null
cp pages/profile.html .backups/profile.html.bak 2>/dev/null
cp pages/workout-completion.html .backups/workout-completion.html.bak 2>/dev/null
echo -e "${GREEN}✓ Backups created in .backups/ folder${NC}"
echo ""

# ════════════════════════════════════════════════════════════════════════════
# FIX: index.html (in root)
# ════════════════════════════════════════════════════════════════════════════
echo "🔄 Fixing index.html..."

# Links to pages should be pages/filename.html
sed -i 's|href="dashboard\.html"|href="pages/dashboard.html"|g' index.html
sed -i 's|href="workout\.html"|href="pages/workout.html"|g' index.html
sed -i 's|href="nutrition\.html"|href="pages/nutrition.html"|g' index.html
sed -i 's|href="profile\.html"|href="pages/profile.html"|g' index.html

# window.location redirects
sed -i "s|window\.location\.href = 'dashboard\.html'|window.location.href = 'pages/dashboard.html'|g" index.html
sed -i 's|window\.location\.href = "dashboard\.html"|window.location.href = "pages/dashboard.html"|g' index.html

echo -e "${GREEN}✓ index.html fixed${NC}"

# ════════════════════════════════════════════════════════════════════════════
# FIX: pages/dashboard.html
# ════════════════════════════════════════════════════════════════════════════
echo "🔄 Fixing pages/dashboard.html..."

# Fix manifest and icons (should go up one level)
sed -i 's|href="./manifest\.json"|href="../manifest.json"|g' pages/dashboard.html
sed -i 's|href="./icons/|href="../icons/|g' pages/dashboard.html

# Fix script sources (should go up one level)
sed -i 's|src="session-cache\.js"|src="../js/session-cache.js"|g' pages/dashboard.html
sed -i 's|src="auth\.js"|src="../js/auth.js"|g' pages/dashboard.html
sed -i 's|src="access-control\.js"|src="../js/access-control.js"|g' pages/dashboard.html
sed -i 's|src="viewport\.js"|src="../viewport.js"|g' pages/dashboard.html

# Fix links to other pages (same folder, no ../)
sed -i 's|href="workout\.html"|href="workout.html"|g' pages/dashboard.html
sed -i 's|href="nutrition\.html"|href="nutrition.html"|g' pages/dashboard.html
sed -i 's|href="profile\.html"|href="profile.html"|g' pages/dashboard.html

# Fix window.location redirects
sed -i "s|window\.location\.href = 'workout\.html'|window.location.href = 'workout.html'|g" pages/dashboard.html
sed -i 's|window\.location\.href = "workout\.html"|window.location.href = "workout.html"|g' pages/dashboard.html
sed -i "s|window\.location\.href = 'nutrition\.html'|window.location.href = 'nutrition.html'|g" pages/dashboard.html
sed -i "s|window\.location\.href = 'index\.html'|window.location.href = '../index.html'|g" pages/dashboard.html
sed -i 's|window\.location\.href = "index\.html"|window.location.href = "../index.html"|g' pages/dashboard.html

# Fix sessionStorage redirects
sed -i "s|sessionStorage\.setItem('redirectTo', 'dashboard\.html')|sessionStorage.setItem('redirectTo', 'pages/dashboard.html')|g" pages/dashboard.html

echo -e "${GREEN}✓ pages/dashboard.html fixed${NC}"

# ════════════════════════════════════════════════════════════════════════════
# FIX: pages/workout.html
# ════════════════════════════════════════════════════════════════════════════
echo "🔄 Fixing pages/workout.html..."

# Fix manifest and icons
sed -i 's|href="./manifest\.json"|href="../manifest.json"|g' pages/workout.html
sed -i 's|href="./icons/|href="../icons/|g' pages/workout.html

# Fix script sources
sed -i 's|src="session-cache\.js"|src="../js/session-cache.js"|g' pages/workout.html
sed -i 's|src="auth\.js"|src="../js/auth.js"|g' pages/workout.html
sed -i 's|src="access-control\.js"|src="../js/access-control.js"|g' pages/workout.html
sed -i 's|src="workout\.js"|src="../js/workout.js"|g' pages/workout.html
sed -i 's|src="viewport\.js"|src="../viewport.js"|g' pages/workout.html

# Fix links to other pages
sed -i 's|href="dashboard\.html"|href="dashboard.html"|g' pages/workout.html
sed -i 's|href="nutrition\.html"|href="nutrition.html"|g' pages/workout.html

# Fix window.location redirects
sed -i "s|window\.location\.href = 'dashboard\.html'|window.location.href = 'dashboard.html'|g" pages/workout.html
sed -i 's|window\.location\.href = "dashboard\.html"|window.location.href = "dashboard.html"|g' pages/workout.html
sed -i "s|window\.location\.href = 'index\.html'|window.location.href = '../index.html'|g" pages/workout.html
sed -i 's|window\.location\.href = "index\.html"|window.location.href = "../index.html"|g' pages/workout.html
sed -i "s|window\.location\.href = 'workout-completion\.html'|window.location.href = 'workout-completion.html'|g" pages/workout.html

echo -e "${GREEN}✓ pages/workout.html fixed${NC}"

# ════════════════════════════════════════════════════════════════════════════
# FIX: pages/nutrition.html
# ════════════════════════════════════════════════════════════════════════════
echo "🔄 Fixing pages/nutrition.html..."

# Fix manifest and icons
sed -i 's|href="./manifest\.json"|href="../manifest.json"|g' pages/nutrition.html
sed -i 's|href="./icons/|href="../icons/|g' pages/nutrition.html

# Fix script sources
sed -i 's|src="session-cache\.js"|src="../js/session-cache.js"|g' pages/nutrition.html
sed -i 's|src="auth\.js"|src="../js/auth.js"|g' pages/nutrition.html
sed -i 's|src="access-control\.js"|src="../js/access-control.js"|g' pages/nutrition.html
sed -i 's|src="nutrition-app\.js"|src="../js/nutrition-app.js"|g' pages/nutrition.html
sed -i 's|src="nutrition-engine\.js"|src="../js/nutrition-engine.js"|g' pages/nutrition.html
sed -i 's|src="viewport\.js"|src="../viewport.js"|g' pages/nutrition.html

# Fix links to other pages
sed -i 's|href="dashboard\.html"|href="dashboard.html"|g' pages/nutrition.html
sed -i 's|href="workout\.html"|href="workout.html"|g' pages/nutrition.html

# Fix window.location redirects
sed -i "s|window\.location\.href = 'dashboard\.html'|window.location.href = 'dashboard.html'|g" pages/nutrition.html
sed -i 's|window\.location\.href = "dashboard\.html"|window.location.href = "dashboard.html"|g' pages/nutrition.html
sed -i "s|window\.location\.href = 'index\.html'|window.location.href = '../index.html'|g" pages/nutrition.html

echo -e "${GREEN}✓ pages/nutrition.html fixed${NC}"

# ════════════════════════════════════════════════════════════════════════════
# FIX: pages/profile.html
# ════════════════════════════════════════════════════════════════════════════
echo "🔄 Fixing pages/profile.html..."

# Fix manifest and icons
sed -i 's|href="./manifest\.json"|href="../manifest.json"|g' pages/profile.html
sed -i 's|href="./icons/|href="../icons/|g' pages/profile.html

# Fix links to other pages
sed -i 's|href="dashboard\.html"|href="dashboard.html"|g' pages/profile.html

# Fix window.location redirects
sed -i "s|window\.location\.href = 'dashboard\.html'|window.location.href = 'dashboard.html'|g" pages/profile.html
sed -i 's|window\.location\.href = "dashboard\.html"|window.location.href = "dashboard.html"|g' pages/profile.html
sed -i "s|window\.location\.href = 'index\.html'|window.location.href = '../index.html'|g" pages/profile.html
sed -i 's|window\.location\.href = "index\.html"|window.location.href = "../index.html"|g' pages/profile.html

echo -e "${GREEN}✓ pages/profile.html fixed${NC}"

# ════════════════════════════════════════════════════════════════════════════
# FIX: pages/workout-completion.html
# ════════════════════════════════════════════════════════════════════════════
echo "🔄 Fixing pages/workout-completion.html..."

# Fix manifest and icons
sed -i 's|href="./manifest\.json"|href="../manifest.json"|g' pages/workout-completion.html
sed -i 's|href="./icons/|href="../icons/|g' pages/workout-completion.html

# Fix window.location redirects
sed -i "s|window\.location\.href = 'dashboard\.html'|window.location.href = 'dashboard.html'|g" pages/workout-completion.html
sed -i 's|window\.location\.href = "dashboard\.html"|window.location.href = "dashboard.html"|g' pages/workout-completion.html

echo -e "${GREEN}✓ pages/workout-completion.html fixed${NC}"

# ════════════════════════════════════════════════════════════════════════════
# SUMMARY
# ════════════════════════════════════════════════════════════════════════════
echo ""
echo "════════════════════════════════════════════════"
echo -e "${GREEN}✅ ALL PATHS FIXED!${NC}"
echo "════════════════════════════════════════════════"
echo ""
echo "📝 Summary of changes:"
echo "  • index.html: Links now point to pages/ folder"
echo "  • dashboard.html: Fixed all resource paths"
echo "  • workout.html: Fixed all resource paths"
echo "  • nutrition.html: Fixed all resource paths"
echo "  • profile.html: Fixed all resource paths"
echo "  • workout-completion.html: Fixed all resource paths"
echo ""
echo "🔗 Correct URLs to use:"
echo "  • Home:      http://127.0.0.1:5500/index.html"
echo "  • Dashboard: http://127.0.0.1:5500/pages/dashboard.html"
echo "  • Workout:   http://127.0.0.1:5500/pages/workout.html"
echo "  • Profile:   http://127.0.0.1:5500/pages/profile.html"
echo ""
echo "💾 Backups saved in .backups/ folder"
echo ""
echo -e "${GREEN}🎉 Ready to test! Reload your browser.${NC}"
echo ""
