import 'package:flutter/foundation.dart';

import '../database/database_helper.dart';
import '../models/body_weight_entry.dart';

/// Хранит записи веса тела. Персистится в SQLite через [DatabaseHelper] —
/// см. [loadFromDatabase]. Живёт на уровне [MainScreen].
class BodyWeightStore extends ChangeNotifier {
  final List<BodyWeightEntry> _entries = [];

  bool isLoaded = false;

  bool get hasEntries => _entries.isNotEmpty;

  /// Записи по возрастанию даты — удобно для графика.
  List<BodyWeightEntry> get entriesAscending {
    final list = List<BodyWeightEntry>.from(_entries);
    list.sort((a, b) => a.date.compareTo(b.date));
    return List.unmodifiable(list);
  }

  /// Записи по убыванию даты — удобно для списка на Profile.
  List<BodyWeightEntry> get entriesDescending => List.unmodifiable(entriesAscending.reversed);

  BodyWeightEntry? get latest {
    if (_entries.isEmpty) return null;
    return entriesAscending.last;
  }

  double? get currentKg => latest?.weightKg;

  /// Разница между двумя последними записями. `null`, если записей меньше двух.
  double? get deltaKg {
    final sorted = entriesAscending;
    if (sorted.length < 2) return null;
    return sorted.last.weightKg - sorted[sorted.length - 2].weightKg;
  }

  Future<void> loadFromDatabase() async {
    final loaded = await DatabaseHelper.instance.getBodyWeightEntries();
    _entries
      ..clear()
      ..addAll(loaded);
    isLoaded = true;
    notifyListeners();
  }

  void addEntry({required DateTime date, required double weightKg}) {
    final entry = BodyWeightEntry(date: date, weightKg: weightKg);
    _entries.add(entry);
    DatabaseHelper.instance.insertBodyWeightEntry(entry);
    notifyListeners();
  }
}
