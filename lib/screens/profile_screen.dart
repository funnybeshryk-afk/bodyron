import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/body_weight_store.dart';
import '../data/entitlement_store.dart';
import '../data/purchase_service.dart';
import '../data/theme_store.dart';
import '../data/user_profile_store.dart';
import '../data/workout_session_store.dart';
import '../l10n/app_localizations.dart';
import '../widgets/profile/app_footer.dart';
import '../widgets/profile/body_weight_section.dart';
import '../widgets/profile/edit_name_dialog.dart';
import '../widgets/profile/export_history_tile.dart';
import '../widgets/profile/name_tile.dart';
import '../widgets/profile/pro_badge.dart';
import '../widgets/profile/pro_debug_toggle.dart';
import '../widgets/profile/pro_purchase_section.dart';
import '../widgets/profile/settings_section.dart';
import '../widgets/section_title.dart';

class ProfileScreen extends StatelessWidget {
  final EntitlementStore entitlementStore;
  final PurchaseService purchaseService;
  final WorkoutSessionStore workoutStore;
  final BodyWeightStore bodyWeightStore;
  final UserProfileStore userProfileStore;
  final ThemeStore themeStore;

  const ProfileScreen({
    super.key,
    required this.entitlementStore,
    required this.purchaseService,
    required this.workoutStore,
    required this.bodyWeightStore,
    required this.userProfileStore,
    required this.themeStore,
  });

  Future<void> _editName(BuildContext context) async {
    final result = await showEditNameDialog(
      context: context,
      currentName: userProfileStore.userName,
    );
    if (result == null) return;
    userProfileStore.setName(result);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: ListenableBuilder(
        listenable: Listenable.merge([entitlementStore, userProfileStore, purchaseService]),
        builder: (context, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      l10n.profileScreenTitle,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                    ),
                    if (entitlementStore.isPro) ...[
                      const SizedBox(width: 10),
                      ProBadge(label: l10n.proBadgeLabel),
                    ],
                  ],
                ),
                const SizedBox(height: 28),
                SectionTitle(title: l10n.proSectionTitle),
                const SizedBox(height: 14),
                ProPurchaseSection(
                  entitlementStore: entitlementStore,
                  purchaseService: purchaseService,
                ),
                const SizedBox(height: 28),
                SectionTitle(title: l10n.profileNameSection),
                const SizedBox(height: 14),
                NameTile(
                  name: userProfileStore.userName,
                  onTap: () => _editName(context),
                ),
                const SizedBox(height: 28),
                SectionTitle(title: l10n.profileBodyWeightSection),
                const SizedBox(height: 14),
                BodyWeightSection(store: bodyWeightStore),
                const SizedBox(height: 28),
                SectionTitle(title: l10n.exportHistorySection),
                const SizedBox(height: 14),
                ExportHistoryTile(store: workoutStore),
                const SizedBox(height: 28),
                SectionTitle(title: l10n.settingsSection),
                const SizedBox(height: 14),
                SettingsSection(workoutStore: workoutStore, themeStore: themeStore),
                if (kDebugMode) ...[
                  const SizedBox(height: 28),
                  SectionTitle(title: l10n.profileDeveloperSection),
                  const SizedBox(height: 14),
                  ProDebugToggle(store: entitlementStore),
                ],
                const SizedBox(height: 36),
                const Center(child: AppFooter()),
              ],
            ),
          );
        },
      ),
    );
  }
}
