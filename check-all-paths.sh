#!/bin/bash
echo "════════════════════════════════════════════════"
echo "COMPREHENSIVE PATH CHECK"
echo "════════════════════════════════════════════════"
echo ""

# Check index.html
echo "✓ index.html:"
grep -n 'href="css/main.css"' index.html > /dev/null && echo "  ✅ CSS: css/main.css" || echo "  ❌ CSS path wrong"
grep -n 'src="js/auth.js"' index.html > /dev/null && echo "  ✅ JS: js/auth.js" || echo "  ❌ JS path wrong"
grep -n 'href="pages/dashboard.html"' index.html > /dev/null && echo "  ✅ Dashboard link: pages/dashboard.html" || echo "  ❌ Dashboard link wrong"
echo ""

# Check dashboard.html
echo "✓ pages/dashboard.html:"
grep -n 'href="../manifest.json"' pages/dashboard.html > /dev/null && echo "  ✅ Manifest: ../manifest.json" || echo "  ❌ Manifest wrong"
grep -n 'src="../js/auth.js"' pages/dashboard.html > /dev/null && echo "  ✅ Auth JS: ../js/auth.js" || echo "  ❌ Auth JS wrong"
grep -n 'href="workout.html"' pages/dashboard.html > /dev/null && echo "  ✅ Workout link: workout.html (same folder)" || echo "  ❌ Workout link wrong"
echo ""

# Check workout.html
echo "✓ pages/workout.html:"
grep -n 'href="../manifest.json"' pages/workout.html > /dev/null && echo "  ✅ Manifest: ../manifest.json" || echo "  ❌ Manifest wrong"
grep -n 'href="../css/main.css"' pages/workout.html > /dev/null && echo "  ✅ CSS: ../css/main.css" || echo "  ❌ CSS wrong"
grep -n 'src="../js/workout.js"' pages/workout.html > /dev/null && echo "  ✅ Workout JS: ../js/workout.js" || echo "  ❌ Workout JS wrong"
echo ""

# Check nutrition.html
echo "✓ pages/nutrition.html:"
grep -n 'href="../manifest.json"' pages/nutrition.html > /dev/null && echo "  ✅ Manifest: ../manifest.json" || echo "  ❌ Manifest wrong"
grep -n 'href="../css/nutrition.css"' pages/nutrition.html > /dev/null && echo "  ✅ CSS: ../css/nutrition.css" || echo "  ❌ CSS wrong"
echo ""

# Check profile.html
echo "✓ pages/profile.html:"
grep -n 'href="../manifest.json"' pages/profile.html > /dev/null && echo "  ✅ Manifest: ../manifest.json" || echo "  ❌ Manifest wrong"
grep -n 'href="../css/main.css"' pages/profile.html > /dev/null && echo "  ✅ CSS: ../css/main.css" || echo "  ❌ CSS wrong"
echo ""

# Check workout-completion.html
echo "✓ pages/workout-completion.html:"
grep -n 'href="../manifest.json"' pages/workout-completion.html > /dev/null && echo "  ✅ Manifest: ../manifest.json" || echo "  ❌ Manifest wrong"
grep -n 'href="../css/main.css"' pages/workout-completion.html > /dev/null && echo "  ✅ CSS: ../css/main.css" || echo "  ❌ CSS wrong"
echo ""

echo "════════════════════════════════════════════════"
echo "CHECK COMPLETE"
echo "════════════════════════════════════════════════"
