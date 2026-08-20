import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

/// Диалог редактирования локального имени пользователя. Возвращает новое
/// имя (или `null`, если пользователь отменил).
Future<String?> showEditNameDialog({
  required BuildContext context,
  required String? currentName,
}) {
  return showDialog<String>(
    context: context,
    builder: (context) => _EditNameDialog(currentName: currentName),
  );
}

class _EditNameDialog extends StatefulWidget {
  final String? currentName;

  const _EditNameDialog({required this.currentName});

  @override
  State<_EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<_EditNameDialog> {
  late final _controller = TextEditingController(text: widget.currentName ?? '');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.pop(context, _controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return AlertDialog(
      backgroundColor: colors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        l10n.editNameDialogTitle,
        style: const TextStyle(fontWeight: FontWeight.w900),
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        style: TextStyle(color: colors.textPrimary),
        decoration: InputDecoration(
          hintText: l10n.nameFieldHint,
          hintStyle: TextStyle(color: colors.textFaint),
          filled: true,
          fillColor: colors.cardAlt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (_) => _submit(),
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
          child: Text(l10n.save, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}
