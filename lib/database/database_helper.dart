import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/body_weight_entry.dart';
import '../models/completed_workout.dart';
import '../models/exercise_definition.dart';

/// SQLite persistence for workout history, body weight entries, custom
/// exercises and small app settings (name, default rest duration).
class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  static const int _schemaVersion = 2;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'bodyron.db');

    return openDatabase(
      path,
      version: _schemaVersion,
      onCreate: (db, version) => _createSchema(db),
      onUpgrade: (db, oldVersion, newVersion) async {
        // Pre-2.0 schema was never actually written to by the app (only a
        // seeded, unused table) — safe to drop and recreate.
        await db.execute('DROP TABLE IF EXISTS exercises');
        await db.execute('DROP TABLE IF EXISTS workouts');
        await db.execute('DROP TABLE IF EXISTS workout_exercises');
        await db.execute('DROP TABLE IF EXISTS workout_sets');
        await _createSchema(db);
      },
    );
  }

  Future<void> _createSchema(Database db) async {
    await db.execute('''
      CREATE TABLE custom_exercises (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        muscle_group TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        name TEXT NOT NULL,
        duration_minutes INTEGER NOT NULL,
        volume_kg REAL NOT NULL,
        pr_count INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE workout_exercises (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workout_id INTEGER NOT NULL,
        exercise_name TEXT NOT NULL,
        muscle_group TEXT NOT NULL,
        exercise_order INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE workout_sets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workout_exercise_id INTEGER NOT NULL,
        weight REAL NOT NULL,
        reps INTEGER NOT NULL,
        rpe REAL,
        to_failure INTEGER NOT NULL DEFAULT 0,
        set_order INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (workout_exercise_id)
          REFERENCES workout_exercises(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE body_weight_entries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        weight_kg REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE app_settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
  }

  // ---------------------------------------------------------------------
  // Workouts
  // ---------------------------------------------------------------------

  Future<void> insertCompletedWorkout(CompletedWorkout workout) async {
    final db = await database;

    await db.transaction((txn) async {
      final workoutId = await txn.insert('workouts', {
        'date': workout.date.toIso8601String(),
        'name': workout.name,
        'duration_minutes': workout.durationMinutes,
        'volume_kg': workout.volumeKg,
        'pr_count': workout.prCount,
      });

      for (var exerciseOrder = 0; exerciseOrder < workout.exercises.length; exerciseOrder++) {
        final exercise = workout.exercises[exerciseOrder];

        final workoutExerciseId = await txn.insert('workout_exercises', {
          'workout_id': workoutId,
          'exercise_name': exercise.exerciseName,
          'muscle_group': exercise.muscleGroup,
          'exercise_order': exerciseOrder,
        });

        for (var setOrder = 0; setOrder < exercise.sets.length; setOrder++) {
          final set = exercise.sets[setOrder];

          await txn.insert('workout_sets', {
            'workout_exercise_id': workoutExerciseId,
            'weight': set.weight,
            'reps': set.reps,
            'rpe': set.rpe,
            'to_failure': set.toFailure ? 1 : 0,
            'set_order': setOrder,
          });
        }
      }
    });
  }

  /// Все завершённые тренировки в хронологическом порядке (старые → новые).
  Future<List<CompletedWorkout>> getWorkoutHistory() async {
    final db = await database;

    final workoutRows = await db.query('workouts', orderBy: 'date ASC, id ASC');
    final result = <CompletedWorkout>[];

    for (final workoutRow in workoutRows) {
      final workoutId = workoutRow['id'] as int;

      final exerciseRows = await db.query(
        'workout_exercises',
        where: 'workout_id = ?',
        whereArgs: [workoutId],
        orderBy: 'exercise_order ASC',
      );

      final exercises = <CompletedExercise>[];

      for (final exerciseRow in exerciseRows) {
        final workoutExerciseId = exerciseRow['id'] as int;

        final setRows = await db.query(
          'workout_sets',
          where: 'workout_exercise_id = ?',
          whereArgs: [workoutExerciseId],
          orderBy: 'set_order ASC',
        );

        exercises.add(
          CompletedExercise(
            exerciseName: exerciseRow['exercise_name'] as String,
            muscleGroup: exerciseRow['muscle_group'] as String,
            sets: [for (final setRow in setRows) CompletedWorkoutSet.fromMap(setRow)],
          ),
        );
      }

      result.add(
        CompletedWorkout(
          date: DateTime.parse(workoutRow['date'] as String),
          name: workoutRow['name'] as String,
          durationMinutes: workoutRow['duration_minutes'] as int,
          volumeKg: (workoutRow['volume_kg'] as num).toDouble(),
          prCount: workoutRow['pr_count'] as int,
          exercises: exercises,
        ),
      );
    }

    return result;
  }

  // ---------------------------------------------------------------------
  // Custom exercises
  // ---------------------------------------------------------------------

  Future<void> insertCustomExercise(ExerciseDefinition exercise) async {
    final db = await database;
    await db.insert(
      'custom_exercises',
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<ExerciseDefinition>> getCustomExercises() async {
    final db = await database;
    final rows = await db.query('custom_exercises', orderBy: 'name ASC');
    return [for (final row in rows) ExerciseDefinition.fromMap(row)];
  }

  // ---------------------------------------------------------------------
  // Body weight
  // ---------------------------------------------------------------------

  Future<void> insertBodyWeightEntry(BodyWeightEntry entry) async {
    final db = await database;
    await db.insert('body_weight_entries', entry.toMap());
  }

  Future<List<BodyWeightEntry>> getBodyWeightEntries() async {
    final db = await database;
    final rows = await db.query('body_weight_entries', orderBy: 'date ASC, id ASC');
    return [for (final row in rows) BodyWeightEntry.fromMap(row)];
  }

  // ---------------------------------------------------------------------
  // Settings
  // ---------------------------------------------------------------------

  Future<void> setSetting(String key, String value) async {
    final db = await database;
    await db.insert(
      'app_settings',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getSetting(String key) async {
    final db = await database;
    final rows = await db.query(
      'app_settings',
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return rows.first['value'] as String?;
  }
}
