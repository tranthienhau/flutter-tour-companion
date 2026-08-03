import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../state/providers.dart';
import '../widgets/common.dart';
import 'day_detail_screen.dart';
import 'activity_detail_screen.dart';

/// Screen 03 - Home "What's next?". A focal gradient hero for the next event,
/// today's timeline, and quick actions.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tour = ref.watch(tourProvider)!;
    final offline = ref.watch(offlineProvider);
    final today = tour.itinerary.firstWhere((d) => d.status == DayStatus.today,
        orElse: () => tour.itinerary.first);
    final next = today.activities.firstWhere(
        (a) => a.category == 'Transfer' || a.category == 'Match',
        orElse: () => today.activities.first);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          TourHeader(
              tourName: 'Ashes Tour AU',
              groupLabel: tour.groupLabel,
              offline: offline),
          const SizedBox(height: 20),
          _WhatsNextCard(activity: next),
          const SizedBox(height: 24),
          Row(
            children: [
              Text('Today', style: AppText.title()),
              const Spacer(),
              Text(today.dateLabel, style: AppText.caption()),
            ],
          ),
          const SizedBox(height: 12),
          SoftCard(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                for (int i = 0; i < today.activities.length; i++)
                  _TimelineRow(
                    activity: today.activities[i],
                    first: i == 0,
                    last: i == today.activities.length - 1,
                    highlight: today.activities[i].id == next.id,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ActivityDetailScreen(
                            activity: today.activities[i]))),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _QuickAction(
                  icon: Icons.map_outlined,
                  label: 'Map',
                  onTap: () {}),
              const SizedBox(width: 12),
              _QuickAction(
                  icon: Icons.hotel_outlined,
                  label: 'Hotel',
                  onTap: () {}),
              const SizedBox(width: 12),
              _QuickAction(
                  icon: Icons.event_note_outlined,
                  label: 'Full day',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => DayDetailScreen(day: today)))),
            ],
          ),
        ],
      ),
    );
  }
}

class _WhatsNextCard extends StatelessWidget {
  final Activity activity;
  const _WhatsNextCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: kCardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("WHAT'S NEXT",
                  style: AppText.caption().copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(AppRadius.pill)),
                child: Text('in 45 min',
                    style: AppText.caption().copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(activity.title,
              style: AppText.display().copyWith(color: Colors.white)),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.schedule, color: Colors.white, size: 18),
              const SizedBox(width: 6),
              Text(activity.time,
                  style: AppText.label().copyWith(color: Colors.white)),
              const SizedBox(width: 18),
              const Icon(Icons.place_outlined, color: Colors.white, size: 18),
              const SizedBox(width: 6),
              Flexible(
                child: Text(activity.meetingPoint ?? activity.venue,
                    style: AppText.label().copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final Activity activity;
  final bool first;
  final bool last;
  final bool highlight;
  final VoidCallback onTap;
  const _TimelineRow(
      {required this.activity,
      required this.first,
      required this.last,
      required this.highlight,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(width: 12),
            Column(
              children: [
                Container(
                    width: 2,
                    height: 10,
                    color: first ? Colors.transparent : AppColors.border),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: highlight ? AppColors.accent : AppColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: highlight
                              ? AppColors.accent
                              : AppColors.textTertiary,
                          width: 2)),
                ),
                Expanded(
                    child: Container(
                        width: 2,
                        color: last ? Colors.transparent : AppColors.border)),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      highlight ? AppColors.accentTint : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.control),
                ),
                child: Row(
                  children: [
                    SizedBox(
                        width: 62,
                        child: Text(activity.time,
                            style: AppText.caption().copyWith(
                                fontWeight: FontWeight.w600,
                                color: highlight
                                    ? AppColors.accentPressed
                                    : AppColors.textSecondary))),
                    const SizedBox(width: 8),
                    Icon(activity.icon,
                        size: 18, color: AppColors.textSecondary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(activity.title,
                              style: AppText.label().copyWith(
                                  fontWeight: FontWeight.w600)),
                          Text(activity.venue, style: AppText.caption()),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right,
                        color: AppColors.textTertiary, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickAction(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: SoftCard(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                    color: AppColors.accentTint, shape: BoxShape.circle),
                child: Icon(icon, color: AppColors.accentPressed),
              ),
              const SizedBox(height: 8),
              Text(label, style: AppText.caption()),
            ],
          ),
        ),
      ),
    );
  }
}
