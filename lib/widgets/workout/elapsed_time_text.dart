import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/workout_session_store.dart';

/// Текст с длительностью текущей тренировки, обновляется раз в секунду.
class ElapsedTimeText extends StatefulWidget {
  final WorkoutSessionStore store;
  final TextStyle? style;

  const ElapsedTimeText({
    super.key,
    required this.store,
    this.style,
  });

  @override
  State<ElapsedTimeText> createState() => _ElapsedTimeTextState();
}

class _ElapsedTimeTextState extends State<ElapsedTimeText> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.store.elapsed;
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final text = hours > 0
        ? '${hours.toString().padLeft(2, '0')}:$minutes:$seconds'
        : '$minutes:$seconds';

    return Text(
      text,
      style: widget.style ??
          const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
    );
  }
}
