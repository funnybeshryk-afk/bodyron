import '../models/training_article.dart';

/// Статический набор обучающих статей по базовым принципам тренинга.
class TrainingArticles {
  TrainingArticles._();

  static const List<TrainingArticle> all = [
    TrainingArticle(
      id: 'progressive_overload',
      title: 'Progressive Overload 101',
      category: 'Fundamentals',
      paragraphs: [
        'Progressive overload is the single most important principle in strength training: to keep getting stronger, you need to gradually increase the demand you place on your muscles over time.',
        "The simplest way to apply it is to add a little weight to the bar once you can comfortably complete all your target sets and reps with good form. A 2.5kg increase on a big lift is plenty — small, consistent jumps beat big, inconsistent ones.",
        "If you can't add weight yet, you can still overload by adding a rep, adding a set, or slowing down the tempo of each rep. Any of these makes the set harder than last time, which is all overload really means.",
        "What doesn't count as progress: chasing heavier numbers with worse form. A rep that isn't controlled through a full range of motion trains bad habits, not strength.",
        "BODYRON's Smart Progression (PRO) tracks your last sets for each exercise and suggests the next weight and rep target automatically, so you don't have to do this math yourself.",
      ],
    ),
    TrainingArticle(
      id: 'rest_between_sets',
      title: 'How Much Rest Between Sets?',
      category: 'Fundamentals',
      paragraphs: [
        "Rest time between sets depends on what you're training for. For pure strength on heavy compound lifts (squat, bench, deadlift), 2-4 minutes lets your nervous system and muscles recover enough to lift near-maximal weight again.",
        "For muscle growth (hypertrophy) with moderate weights and higher reps, 60-90 seconds is usually enough — you want to keep the muscle under tension across the workout without resting so long that your sessions drag on forever.",
        "For small isolation movements like curls or lateral raises, 30-60 seconds is often plenty, since the joints and stabilizers involved recover faster than after a heavy squat.",
        "If you're gasping for air or your next set falls apart in quality, you probably rested too little. If you're getting cold and losing focus, you probably rested too long.",
        "BODYRON's rest timer defaults to a sensible starting point, but feel free to adjust it per exercise in Settings or right from the workout screen.",
      ],
    ),
    TrainingArticle(
      id: 'warming_up',
      title: 'Why Warming Up Matters',
      category: 'Fundamentals',
      paragraphs: [
        "A proper warm-up isn't about burning calories — it's about preparing your joints, muscles, and nervous system to handle the weight you're about to lift.",
        'Start with a few minutes of light cardio or dynamic movement to raise your body temperature and blood flow, especially if you\'re training first thing in the morning.',
        'Then do warm-up sets for your first exercise: light weight for a few reps, then step up in weight while dropping reps, until you reach your working weight. For a 100kg squat, that might look like 40kg×8, 60kg×5, 80kg×3, then straight into your working sets.',
        "You don't need to repeat this full ramp-up for every exercise that trains the same muscles — your body is usually warm enough after the first one or two exercises of a session.",
        "Skipping warm-ups doesn't just increase injury risk — your first working set often feels heavier and shakier than it should, simply because your body wasn't ready for it yet.",
      ],
    ),
    TrainingArticle(
      id: 'rep_ranges',
      title: 'Choosing the Right Rep Range',
      category: 'Fundamentals',
      paragraphs: [
        "Rep ranges are guidelines, not strict rules, but they're a useful way to bias your training toward a specific goal.",
        '1-5 reps per set, with heavy weight, is the classic range for building maximal strength — think powerlifting-style training on squat, bench, and deadlift.',
        '6-12 reps is the traditional hypertrophy (muscle growth) range — heavy enough to challenge the muscle, light enough to accumulate meaningful volume across a workout.',
        '13+ reps builds muscular endurance and is often used for accessory or isolation work like curls, lateral raises, or ab exercises.',
        'In practice, most well-rounded programs use a mix of all three ranges across different exercises. What matters most is training close to failure (or logging your RPE) in whatever range you choose.',
      ],
    ),
    TrainingArticle(
      id: 'rpe_and_failure',
      title: 'RPE and Training to Failure',
      category: 'Intensity',
      paragraphs: [
        "RPE (Rate of Perceived Exertion) is a 1-10 scale for how hard a set felt. RPE 10 means you couldn't have done another rep — true muscular failure. RPE 8 means you probably had 2 more reps left in the tank.",
        "Logging RPE (or marking a set 'To Failure' in BODYRON) gives you — and Smart Progression — a much clearer picture of your effort than weight and reps alone. Two sets of 100kg×5 can be wildly different workouts depending on how close to failure they were.",
        "You don't need to train to failure on every set to make progress. In fact, doing so on every single set of every session tends to accumulate fatigue faster than it builds strength.",
        'A common, sustainable approach: keep most sets in the RPE 7-8 range (leaving 2-3 reps in reserve), and save true failure for the last set of an exercise, if at all.',
        "If you're logging sets with no idea what RPE means, a rough gut check works fine: could you have done meaningfully more reps with good form? If yes, it wasn't RPE 9-10.",
      ],
    ),
    TrainingArticle(
      id: 'deload_week',
      title: 'When to Take a Deload Week',
      category: 'Recovery',
      paragraphs: [
        "A deload is a planned week of reduced training stress — lighter weights, fewer sets, or both — that lets your body fully recover before the next block of hard training.",
        "It's not a sign of weakness or falling behind. Fatigue accumulates faster than most people realize, and a well-timed deload usually leaves you stronger in the following weeks, not weaker.",
        'Common signs it\'s time for one: your lifts have stalled or gone backward for 2-3 sessions in a row despite good effort, you feel unusually run-down, or your joints are nagging even though nothing is technically injured.',
        'A simple deload approach: keep the same exercises, but cut your working weight by about 40-50% and your sets by about half for one week. You should leave every set feeling like you barely worked.',
        "BODYRON's plateau detection flags exercises where your top set hasn't improved in 3 sessions in a row — that's a good moment to consider a deload before pushing further.",
      ],
    ),
    TrainingArticle(
      id: 'reading_smart_progression',
      title: 'Reading Your Smart Progression Suggestions',
      category: 'BODYRON Features',
      paragraphs: [
        "Smart Progression (PRO) looks at your most recent sets for an exercise and suggests a weight and rep target for your next session, so you don't have to guess.",
        "If your last set was at the top of your rep range and close to failure, it'll usually suggest a small weight increase with your reps reset to the bottom of the range — that's the classic 'add weight, drop reps' progression.",
        'If your last set was solid but not maxed out, it may suggest staying at the same weight and simply adding a rep — this is called double progression, and it\'s a gentler, very sustainable way to get stronger.',
        "If you missed your rep target, it'll usually suggest repeating the same weight rather than pushing forward — there's no shame in a retry; consistency beats forcing progress that isn't there yet.",
        "These suggestions are a starting point, not an order. Your energy, sleep, and stress on a given day all matter — feel free to adjust up or down based on how the first set actually feels.",
      ],
    ),
    TrainingArticle(
      id: 'tracking_prs',
      title: 'Tracking Personal Records the Right Way',
      category: 'BODYRON Features',
      paragraphs: [
        'BODYRON tracks personal records using estimated one-rep max (e1RM) — a formula that combines the weight and reps of your best set to estimate what you could lift for a single rep.',
        'This means a PR isn\'t only about lifting your heaviest ever weight — a new best set of 80kg×8 can beat an old best of 90kg×3, because it represents more estimated strength overall.',
        "A PR is only counted for an exercise you've logged across at least two different workouts, so it reflects real progress over time rather than a one-off good day.",
        'Watching your PRs trend upward over weeks and months is a much better strength signal than judging any single session — some workouts will just be off days, and that\'s normal.',
        'You can see all your current PRs on the Progress tab, along with the date they were set — a quick way to spot which lifts have plateaued and could use fresh attention.',
      ],
    ),
  ];
}
