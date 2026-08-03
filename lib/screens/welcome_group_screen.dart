import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../state/providers.dart';
import '../widgets/common.dart';
import 'home_shell.dart';

/// Screen 02 - Group welcome. Gradient upper area with a focal success check,
/// a group summary card, and an offline-download toggle.
class WelcomeGroupScreen extends ConsumerWidget {
  const WelcomeGroupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tour = ref.watch(tourProvider)!;
    final offline = ref.watch(offlineProvider);

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 40),
            decoration: const BoxDecoration(gradient: AppColors.heroGradient),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                child: Column(
                  children: [
                    Container(
                      width: 108,
                      height: 108,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 76,
                          height: 76,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(Icons.check_rounded,
                              color: AppColors.accent, size: 44),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Welcome, ${tour.groupLabel}',
                        style: AppText.display().copyWith(color: Colors.white)),
                    const SizedBox(height: 6),
                    Text(tour.tourName,
                        style: AppText.body().copyWith(
                            color: Colors.white.withValues(alpha: 0.92))),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Column(
                children: [
                  SoftCard(
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _Stat('${tour.cities}', 'cities'),
                        _divider(),
                        _Stat('${tour.days}', 'days'),
                        _divider(),
                        _Stat('${tour.delegates}', 'delegates'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SoftCard(
                    child: Row(
                      children: [
                        const Icon(Icons.cloud_download_outlined,
                            color: AppColors.accent),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Download itinerary for offline use',
                                  style: AppText.label()),
                              const SizedBox(height: 2),
                              Text('Works with no signal at the venue',
                                  style: AppText.caption()),
                            ],
                          ),
                        ),
                        Switch(
                          value: offline,
                          activeTrackColor: AppColors.accent,
                          onChanged: (v) =>
                              ref.read(offlineProvider.notifier).state = v,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton(
                    label: 'Enter app',
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeShell()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Container(width: 1, height: 40, color: AppColors.border);
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat(this.value, this.label);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: AppText.display()
                .copyWith(fontSize: 28, color: AppColors.accent)),
        const SizedBox(height: 2),
        Text(label, style: AppText.caption()),
      ],
    );
  }
}
