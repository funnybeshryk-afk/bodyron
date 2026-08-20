import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/body_weight_store.dart';
import '../../l10n/app_localizations.dart';
import '../../models/body_weight_entry.dart';
import '../../theme/app_palette.dart';

/// Линейный график веса тела по времени.
class BodyWeightChart extends StatelessWidget {
  final BodyWeightStore store;

  const BodyWeightChart({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final colors = context.colors;
        final entries = store.entriesAscending;

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
                l10n.progressWeightChartTitle,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: colors.textMuted,
                ),
              ),
              const SizedBox(height: 14),
              if (entries.length < 2)
                SizedBox(
                  height: 140,
                  child: Center(
                    child: Text(
                      l10n.progressNoWeightDataHint,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colors.textMuted, fontSize: 13),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 160,
                  child: _Chart(entries: entries),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Chart extends StatelessWidget {
  final List<BodyWeightEntry> entries;

  const _Chart({required this.entries});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spots = [
      for (var i = 0; i < entries.length; i++) FlSpot(i.toDouble(), entries[i].weightKg),
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
