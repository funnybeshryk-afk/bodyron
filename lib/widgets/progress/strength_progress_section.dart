import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/entitlement_store.dart';
import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';
import '../pro_teaser_card.dart';

/// PRO-секция: выбор упражнения (chips) + линейный график оценочного 1ПМ
/// (формула Эпли) по датам тренировок для выбранного упражнения.
class StrengthProgressSection extends StatefulWidget {
  final WorkoutSessionStore store;
  final EntitlementStore entitlementStore;

  const StrengthProgressSection({
    super.key,
    required this.store,
    required this.entitlementStore,
  });

  @override
  State<StrengthProgressSection> createState() => _StrengthProgressSectionState();
}

class _StrengthProgressSectionState extends State<StrengthProgressSection> {
  String? _selectedExercise;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final exerciseNames = widget.store.exerciseNamesInHistory;

    if (exerciseNames.isEmpty) return const SizedBox.shrink();

    if (_selectedExercise == null || !exerciseNames.contains(_selectedExercise)) {
      _selectedExercise = exerciseNames.first;
    }

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
            l10n.strengthProgressTitle,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 14),
          if (!widget.entitlementStore.isPro)
            ProTeaserCard(
              title: l10n.strengthProgressTeaserTitle,
              subtitle: l10n.strengthProgressTeaserSubtitle,
              icon: Icons.show_chart,
            )
          else ...[
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: exerciseNames.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final name = exerciseNames[index];
                  final active = name == _selectedExercise;
                  return ChoiceChip(
                    label: Text(name),
                    selected: active,
                    onSelected: (_) => setState(() => _selectedExercise = name),
                    selectedColor: colors.accent,
                    backgroundColor: colors.cardAlt,
                    labelStyle: TextStyle(
                      color: active ? Colors.white : colors.textSecondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.5,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Builder(
              builder: (context) {
                final series = widget.store.e1rmHistoryFor(_selectedExercise!);
                if (series.length < 2) {
                  return SizedBox(
                    height: 140,
                    child: Center(
                      child: Text(
                        l10n.strengthProgressNoDataHint,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colors.textMuted, fontSize: 13),
                      ),
                    ),
                  );
                }
                return SizedBox(
                  height: 160,
                  child: _Chart(series: series),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  final List<MapEntry<DateTime, double>> series;

  const _Chart({required this.series});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spots = [
      for (var i = 0; i < series.length; i++) FlSpot(i.toDouble(), series[i].value),
    ];
    final minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY).abs() < 1 ? 1.0 : (maxY - minY) * 0.2;

    return LineChart(
      LineChartData(
        minY: minY - padding,
        maxY: maxY + padding,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => colors.cardAlt,
            getTooltipItems: (touchedSpots) {
              return touchedSpots
                  .map(
                    (s) => LineTooltipItem(
                      '${s.y.toStringAsFixed(1)} kg',
                      TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w800),
                    ),
                  )
                  .toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: colors.accent,
            barWidth: 3,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: colors.accent.withValues(alpha: 0.12),
            ),
          ),
        ],
      ),
    );
  }
}
