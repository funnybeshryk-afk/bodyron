import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

/// Столбчатый график тренировочного объёма по неделям.
class WeeklyVolumeChart extends StatelessWidget {
  final WorkoutSessionStore store;

  const WeeklyVolumeChart({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final volumeByWeek = store.weeklyVolume;
    final weeks = volumeByWeek.keys.toList()..sort();
    final recentWeeks = weeks.length > 8 ? weeks.sublist(weeks.length - 8) : weeks;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.progressVolumeChartTitle,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 14),
          if (recentWeeks.isEmpty)
            SizedBox(
              height: 140,
              child: Center(
                child: Text(
                  l10n.progressNoVolumeDataHint,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colors.textMuted, fontSize: 13),
                ),
              ),
            )
          else
            SizedBox(
              height: 160,
              child: _Chart(weeks: recentWeeks, volumeByWeek: volumeByWeek),
            ),
        ],
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  final List<DateTime> weeks;
  final Map<DateTime, double> volumeByWeek;

  const _Chart({required this.weeks, required this.volumeByWeek});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final maxVolume = volumeByWeek.values.reduce((a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        maxY: maxVolume * 1.2,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= weeks.length) return const SizedBox.shrink();
                final week = weeks[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '${week.day}/${week.month}',
                    style: TextStyle(fontSize: 9, color: colors.textMuted),
                  ),
                );
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => colors.cardAlt,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toStringAsFixed(0)} kg',
                TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w800),
              );
            },
          ),
        ),
        barGroups: [
          for (var i = 0; i < weeks.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: volumeByWeek[weeks[i]] ?? 0,
                  color: colors.accent,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
