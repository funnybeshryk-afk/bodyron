import 'package:flutter/material.dart';

import '../../data/body_weight_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

/// Диалог добавления записи веса тела: дата (по умолчанию сегодня) + вес.
Future<void> showAddBodyWeightDialog({
  required BuildContext context,
  required BodyWeightStore store,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _AddBodyWeightDialog(store: store),
  );
}

class _AddBodyWeightDialog extends StatefulWidget {
  final BodyWeightStore store;

  const _AddBodyWeightDialog({required this.store});

  @override
  State<_AddBodyWeightDialog> createState() => _AddBodyWeightDialogState();
}

class _AddBodyWeightDialogState extends State<_AddBodyWeightDialog> {
  final _controller = TextEditingController();
  DateTime _date = DateTime.now();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    final weight = double.tryParse(_controller.text.replaceAll(',', '.'));
    if (weight == null || weight <= 0) {
      setState(() => _error = l10n.weightEntryInvalidMessage);
      return;
    }
    widget.store.addEntry(date: _date, weightKg: weight);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return AlertDialog(
      backgroundColor: colors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        l10n.addWeightEntryDialogTitle,
        style: const TextStyle(fontWeight: FontWeight.w900),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(color: colors.textPrimary),
            decoration: InputDecoration(
              labelText: l10n.weightFieldLabel,
              labelStyle: TextStyle(color: colors.textMuted),
              errorText: _error,
              filled: true,
              fillColor: colors.cardAlt,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 14),
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: colors.cardAlt,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined, size: 16, color: colors.textMuted),
                  const SizedBox(width: 10),
                  Text(
                    '${_date.day.toString().padLeft(2, '0')}.'
                    '${_date.month.toString().padLeft(2, '0')}.'
                    '${_date.year}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel, style: TextStyle(color: colors.textSecondary)),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.accent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(l10n.add, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}
