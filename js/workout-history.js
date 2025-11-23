// ═══════════════════════════════════════════════════════════════════════════
// VILTRUM FITNESS - WORKOUT HISTORY & FAVORITES
// Track workout completion, favorites, and personal records
// ═══════════════════════════════════════════════════════════════════════════

// Storage keys
const STORAGE_KEYS = {
  HISTORY: 'viltrum_workout_history',
  FAVORITES: 'viltrum_favorites',
  WEIGHTS: 'viltrum_exercise_weights',
  FIRST_TIME: 'viltrum_first_time_user'
};

// ═══════════════════════════════════════════════════════════════════════════
// WORKOUT HISTORY
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Get workout history
 * @returns {Array} Array of workout history entries
 */
export function getWorkoutHistory() {
  try {
    const history = localStorage.getItem(STORAGE_KEYS.HISTORY);
    return history ? JSON.parse(history) : [];
  } catch (error) {
    console.error('Error loading workout history:', error);
    return [];
  }
}

/**
 * Add workout to history
 * @param {string} workoutName - Name of completed workout
 * @param {number} duration - Duration in seconds
 * @param {Object} exerciseWeights - Object with exercise names as keys and weights as values
 */
export function addWorkoutToHistory(workoutName, duration, exerciseWeights = {}) {
  try {
    const history = getWorkoutHistory();
    const entry = {
      id: Date.now(),
      workoutName,
      duration,
      completedAt: new Date().toISOString(),
      exerciseWeights
    };
    
    history.unshift(entry); // Add to beginning
    
    // Keep last 100 workouts
    if (history.length > 100) {
      history.splice(100);
    }
    
    localStorage.setItem(STORAGE_KEYS.HISTORY, JSON.stringify(history));
    
    // Update exercise weights
    if (Object.keys(exerciseWeights).length > 0) {
      updateExerciseWeights(exerciseWeights);
    }
    
    return entry;
  } catch (error) {
    console.error('Error saving workout to history:', error);
    return null;
  }
}

/**
 * Get workout statistics
 * @returns {Object} Statistics about workouts
 */
export function getWorkoutStats() {
  const history = getWorkoutHistory();
  
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  
  const thisWeek = new Date(today);
  thisWeek.setDate(thisWeek.getDate() - 7);
  
  const thisMonth = new Date(today);
  thisMonth.setMonth(thisMonth.getMonth() - 1);
  
  const stats = {
    total: history.length,
    today: 0,
    thisWeek: 0,
    thisMonth: 0,
    lastWorkout: history[0] || null,
    totalDuration: 0,
    favoriteWorkouts: {}
  };
  
  history.forEach(entry => {
    const date = new Date(entry.completedAt);
    date.setHours(0, 0, 0, 0);
    
    if (date.getTime() === today.getTime()) stats.today++;
    if (date >= thisWeek) stats.thisWeek++;
    if (date >= thisMonth) stats.thisMonth++;
    
    stats.totalDuration += entry.duration || 0;
    
    // Count workout frequency
    if (!stats.favoriteWorkouts[entry.workoutName]) {
      stats.favoriteWorkouts[entry.workoutName] = 0;
    }
    stats.favoriteWorkouts[entry.workoutName]++;
  });
  
  return stats;
}

/**
 * Clear workout history
 */
export function clearWorkoutHistory() {
  localStorage.removeItem(STORAGE_KEYS.HISTORY);
}

// ═══════════════════════════════════════════════════════════════════════════
// FAVORITES
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Get favorite workouts
 * @returns {Array} Array of favorite workout names
 */
export function getFavorites() {
  try {
    const favorites = localStorage.getItem(STORAGE_KEYS.FAVORITES);
    return favorites ? JSON.parse(favorites) : [];
  } catch (error) {
    console.error('Error loading favorites:', error);
    return [];
  }
}

/**
 * Check if workout is favorite
 * @param {string} workoutName - Name of workout
 * @returns {boolean} True if favorite
 */
export function isFavorite(workoutName) {
  const favorites = getFavorites();
  return favorites.includes(workoutName);
}

/**
 * Toggle favorite status
 * @param {string} workoutName - Name of workout
 * @returns {boolean} New favorite status
 */
export function toggleFavorite(workoutName) {
  try {
    const favorites = getFavorites();
    const index = favorites.indexOf(workoutName);
    
    if (index === -1) {
      // Add to favorites
      favorites.push(workoutName);
    } else {
      // Remove from favorites
      favorites.splice(index, 1);
    }
    
    localStorage.setItem(STORAGE_KEYS.FAVORITES, JSON.stringify(favorites));
    return index === -1; // Return true if added
  } catch (error) {
    console.error('Error toggling favorite:', error);
    return false;
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// EXERCISE WEIGHTS
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Get all exercise weights
 * @returns {Object} Object with exercise names as keys and weights as values
 */
export function getExerciseWeights() {
  try {
    const weights = localStorage.getItem(STORAGE_KEYS.WEIGHTS);
    return weights ? JSON.parse(weights) : {};
  } catch (error) {
    console.error('Error loading exercise weights:', error);
    return {};
  }
}

/**
 * Get weight for specific exercise
 * @param {string} exerciseName - Name of exercise
 * @returns {string|null} Weight or null if not found
 */
export function getExerciseWeight(exerciseName) {
  const weights = getExerciseWeights();
  return weights[exerciseName] || null;
}

/**
 * Update exercise weights
 * @param {Object} newWeights - Object with exercise names as keys and weights as values
 */
export function updateExerciseWeights(newWeights) {
  try {
    const weights = getExerciseWeights();
    Object.assign(weights, newWeights);
    localStorage.setItem(STORAGE_KEYS.WEIGHTS, JSON.stringify(weights));
  } catch (error) {
    console.error('Error updating exercise weights:', error);
  }
}

/**
 * Clear all exercise weights
 */
export function clearExerciseWeights() {
  localStorage.removeItem(STORAGE_KEYS.WEIGHTS);
}

// ═══════════════════════════════════════════════════════════════════════════
// FIRST TIME USER
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Check if user is first time
 * @returns {boolean} True if first time
 */
export function isFirstTimeUser() {
  return !localStorage.getItem(STORAGE_KEYS.FIRST_TIME);
}

/**
 * Mark user as not first time
 */
export function markUserAsNotFirstTime() {
  localStorage.setItem(STORAGE_KEYS.FIRST_TIME, 'true');
}

/**
 * Reset first time status (for testing)
 */
export function resetFirstTimeStatus() {
  localStorage.removeItem(STORAGE_KEYS.FIRST_TIME);
}

// ═══════════════════════════════════════════════════════════════════════════
// SHARING
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Share workout completion
 * @param {string} workoutName - Name of completed workout
 * @param {number} duration - Duration in seconds
 */
export function shareWorkoutCompletion(workoutName, duration) {
  const minutes = Math.floor(duration / 60);
  const seconds = duration % 60;
  const timeStr = `${minutes}:${seconds.toString().padStart(2, '0')}`;
  
  const text = `💪 Ho completato "${workoutName}" su Viltrum Fitness in ${timeStr}! #ViltrumFitness #Workout`;
  const url = window.location.origin;
  
  // Check if Web Share API is available (mobile)
  if (navigator.share) {
    navigator.share({
      title: 'Viltrum Fitness',
      text: text,
      url: url
    }).catch(() => {
      // Fallback to copy to clipboard
      copyToClipboard(text + '\n' + url);
    });
  } else {
    // Fallback to copy to clipboard
    copyToClipboard(text + '\n' + url);
  }
}

/**
 * Copy text to clipboard
 * @param {string} text - Text to copy
 */
function copyToClipboard(text) {
  if (navigator.clipboard) {
    navigator.clipboard.writeText(text).then(() => {
      alert('✅ Condivisione copiata negli appunti!');
    }).catch(() => {
      alert('❌ Impossibile copiare negli appunti');
    });
  } else {
    // Fallback for older browsers
    const textarea = document.createElement('textarea');
    textarea.value = text;
    textarea.style.position = 'fixed';
    textarea.style.opacity = '0';
    document.body.appendChild(textarea);
    textarea.select();
    try {
      document.execCommand('copy');
      alert('✅ Condivisione copiata negli appunti!');
    } catch (err) {
      alert('❌ Impossibile copiare negli appunti');
    }
    document.body.removeChild(textarea);
  }
}
