import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../state/providers.dart';
import '../widgets/common.dart';

/// Screen 11 - Delegate profile and settings. Grouped list on tinted surface.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tour = ref.watch(tourProvider)!;
    final offline = ref.watch(offlineProvider);
    final notif = ref.watch(notificationsProvider);
    const d = kDelegate;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                    gradient: AppColors.heroGradient, shape: BoxShape.circle),
                child: Center(
                  child: Text('AM',
                      style: AppText.title().copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(d.name, style: AppText.title()),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        GroupChip(tour.groupLabel),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: AppColors.accentTint,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.pill)),
                          child: Text(d.tourCode,
                              style: AppText.caption().copyWith(
                                  color: AppColors.accentPressed,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _section('My details'),
          SoftCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _row(Icons.restaurant_menu_outlined, 'Dietary', d.dietary),
                _sep(),
                _row(Icons.emergency_outlined, 'Emergency contact',
                    d.emergencyContact),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _section('Settings'),
          SoftCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _toggle(Icons.cloud_download_outlined, 'Offline itinerary',
                    offline, (v) => ref.read(offlineProvider.notifier).state = v),
                _sep(),
                _toggle(Icons.notifications_outlined, 'Push notifications',
                    notif, (v) => ref.read(notificationsProvider.notifier).state = v),
                _sep(),
                _row(Icons.language_outlined, 'Language', 'English'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _section('Support'),
          SoftCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _nav(Icons.headset_mic_outlined, 'Contact tour staff'),
                _sep(),
                _nav(Icons.help_outline, 'Help and FAQ'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SoftCard(
            child: Row(
              children: [
                const Icon(Icons.logout, color: AppColors.danger),
                const SizedBox(width: 14),
                Text('Sign out',
                    style: AppText.label().copyWith(
                        color: AppColors.danger, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String t) => Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(t, style: AppText.caption()),
      );

  Widget _sep() => const Divider(height: 1, color: AppColors.border);

  Widget _row(IconData icon, String label, String value) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accent, size: 22),
            const SizedBox(width: 14),
            Text(label, style: AppText.label()),
            const Spacer(),
            Flexible(
                child: Text(value,
                    textAlign: TextAlign.right,
                    style: AppText.caption(),
                    overflow: TextOverflow.ellipsis)),
          ],
        ),
      );

  Widget _toggle(IconData icon, String label, bool value,
          ValueChanged<bool> onChanged) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accent, size: 22),
            const SizedBox(width: 14),
            Text(label, style: AppText.label()),
            const Spacer(),
            Switch(
                value: value,
                activeTrackColor: AppColors.accent,
                onChanged: onChanged),
          ],
        ),
      );

  Widget _nav(IconData icon, String label) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accent, size: 22),
            const SizedBox(width: 14),
            Text(label, style: AppText.label()),
            const Spacer(),
            const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
      );
}
