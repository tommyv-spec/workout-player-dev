function pickVoice(lang) {
  const all = (speechSynthesis.getVoices && speechSynthesis.getVoices()) || [];
  const want = (lang || "").toLowerCase();

  // Prefer Google voices on Android if present
  const googleFirst = all.find(v =>
    (v.lang || "").toLowerCase().startsWith(want) &&
    /google/i.test(v.name || "")
  );
  if (googleFirst) return googleFirst;

  // Your existing preferences still apply
  for (const name of (SYNTH_PREFS[lang] || [])) {
    const v = all.find(v =>
      (v.lang || "").toLowerCase().startsWith(want) &&
      (v.name || "").includes(name)
    );
    if (v) return v;
  }

  const same = all.filter(v => (v.lang || "").toLowerCase().startsWith(want));
  if (same.length) return same[0];

  return all[0] || null;
}
