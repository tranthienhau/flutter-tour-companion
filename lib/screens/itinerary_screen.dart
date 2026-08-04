import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../state/providers.dart';
import '../widgets/common.dart';
import 'day_detail_screen.dart';
import 'hotels_transfers_screen.dart';

/// Screen 04 - Day-by-day itinerary. Horizontal day chips + a list of day cards
/// with a status dot (done / today / upcoming).
class ItineraryScreen extends ConsumerStatefulWidget {
  const ItineraryScreen({super.key});

  @override
  ConsumerState<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends ConsumerState<ItineraryScreen> {
  int _selected = 3; // Day 4 index

  @override
  Widget build(BuildContext context) {
    final tour = ref.watch(tourProvider)!;
    final offline = ref.watch(offlineProvider);
    final days = tour.itinerary;

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
            child: Row(
              children: [
                Text('Your itinerary', style: AppText.display().copyWith(fontSize: 26)),
                const Spacer(),
                if (offline) const OfflinePill(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 68,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: days.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final d = days[i];
                final sel = i == _selected;
                return GestureDetector(
                  onTap: () => setState(() => _selected = i),
                  child: Container(
                    width: 58,
                    decoration: BoxDecoration(
                      color: sel ? AppColors.accentTint : AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.control),
                      border: Border.all(
                          color: sel ? AppColors.accent : AppColors.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Day',
                            style: AppText.caption().copyWith(
                                fontSize: 11,
                                color: sel
                                    ? AppColors.accentPressed
                                    : AppColors.textTertiary)),
                        Text('${d.dayNumber}',
                            style: AppText.title().copyWith(
                                color: sel
                                    ? AppColors.accentPressed
                                    : AppColors.textPrimary)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              itemCount: days.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _DayCard(
                day: days[i],
                selected: i == _selected,
                onTap: () {
                  setState(() => _selected = i);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => DayDetailScreen(day: days[i])));
                },
                onHotel: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const HotelsTransfersScreen())),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  final DayPlan day;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onHotel;
  const _DayCard(
      {required this.day,
      required this.selected,
      required this.onTap,
      required this.onHotel});

  Color get _statusColor => switch (day.status) {
        DayStatus.done => AppColors.success,
        DayStatus.today => AppColors.accent,
        DayStatus.upcoming => AppColors.textTertiary,
      };

  String get _statusLabel => switch (day.status) {
        DayStatus.done => 'Done',
        DayStatus.today => 'Today',
        DayStatus.upcoming => 'Upcoming',
      };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SoftCard(
        color: selected ? AppColors.accentTint : null,
        child: Row(
          children: [
            Column(
              children: [
                Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: _statusColor, shape: BoxShape.circle)),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Day ${day.dayNumber} - ${day.city}',
                          style: AppText.label()
                              .copyWith(fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text(_statusLabel,
                          style: AppText.caption()
                              .copyWith(color: _statusColor)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(day.headline,
                      style: AppText.title().copyWith(fontSize: 17)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.hotel_outlined,
                          size: 15, color: AppColors.textTertiary),
                      const SizedBox(width: 6),
                      Text(day.hotelName, style: AppText.caption()),
                      const Spacer(),
                      Text(day.dateLabel, style: AppText.caption()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
