import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../state/providers.dart';
import '../widgets/common.dart';

/// Screen 07 - Hotels, transfers and meeting points. Segmented control switches
/// the three reference lists. Reached from the Itinerary tab.
class HotelsTransfersScreen extends ConsumerStatefulWidget {
  const HotelsTransfersScreen({super.key});

  @override
  ConsumerState<HotelsTransfersScreen> createState() =>
      _HotelsTransfersScreenState();
}

class _HotelsTransfersScreenState extends ConsumerState<HotelsTransfersScreen> {
  int _seg = 0;
  static const _segments = ['Hotels', 'Transfers', 'Meeting points'];

  @override
  Widget build(BuildContext context) {
    final tour = ref.watch(tourProvider)!;

    return Scaffold(
      appBar: AppBar(title: Text('Stay and transfers', style: AppText.title())),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Row(
                children: [
                  for (int i = 0; i < _segments.length; i++)
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _seg = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _seg == i
                                ? AppColors.surface
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(AppRadius.pill),
                            boxShadow: _seg == i ? kCardShadow : null,
                          ),
                          child: Text(_segments[i],
                              textAlign: TextAlign.center,
                              style: AppText.caption().copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: _seg == i
                                      ? AppColors.accentPressed
                                      : AppColors.textSecondary)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _seg,
              children: [
                _Hotels(tour.hotels),
                _Transfers(tour.transfers),
                _Meetings(tour.meetingPoints),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Hotels extends StatelessWidget {
  final List<Hotel> hotels;
  const _Hotels(this.hotels);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      itemCount: hotels.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (_, i) {
        final h = hotels[i];
        return SoftCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 96,
                decoration: const BoxDecoration(
                  gradient: AppColors.heroGradient,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(AppRadius.card)),
                ),
                child: Center(
                  child: Icon(Icons.apartment,
                      size: 44, color: Colors.white.withValues(alpha: 0.5)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(h.name,
                                style: AppText.title().copyWith(fontSize: 18))),
                        _iconBtn(Icons.call_outlined),
                        const SizedBox(width: 8),
                        _iconBtn(Icons.place_outlined),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.login,
                          size: 15, color: AppColors.textTertiary),
                      const SizedBox(width: 6),
                      Text('Check in ${h.checkIn}', style: AppText.caption()),
                      const SizedBox(width: 16),
                      const Icon(Icons.logout,
                          size: 15, color: AppColors.textTertiary),
                      const SizedBox(width: 6),
                      Text('Check out ${h.checkOut}',
                          style: AppText.caption()),
                    ]),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Icon(Icons.location_on_outlined,
                          size: 15, color: AppColors.textTertiary),
                      const SizedBox(width: 6),
                      Expanded(
                          child: Text(h.address, style: AppText.caption())),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _iconBtn(IconData icon) => Container(
        width: 38,
        height: 38,
        decoration: const BoxDecoration(
            color: AppColors.accentTint, shape: BoxShape.circle),
        child: Icon(icon, size: 18, color: AppColors.accentPressed),
      );
}

class _Transfers extends StatelessWidget {
  final List<Transfer> transfers;
  const _Transfers(this.transfers);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      itemCount: transfers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final t = transfers[i];
        return SoftCard(
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                    color: AppColors.accentTint, shape: BoxShape.circle),
                child: const Icon(Icons.directions_bus_outlined,
                    color: AppColors.accentPressed),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${t.mode} - ${t.time}',
                        style: AppText.label()
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text('${t.from}  ->  ${t.to}', style: AppText.caption()),
                  ],
                ),
              ),
              const Icon(Icons.place_outlined, color: AppColors.textTertiary),
            ],
          ),
        );
      },
    );
  }
}

class _Meetings extends StatelessWidget {
  final List<MeetingPoint> points;
  const _Meetings(this.points);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      itemCount: points.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) {
        final m = points[i];
        return SoftCard(
          child: Row(
            children: [
              const Icon(Icons.push_pin_outlined, color: AppColors.accent),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.label,
                        style: AppText.label()
                            .copyWith(fontWeight: FontWeight.w600)),
                    Text(m.location, style: AppText.caption()),
                  ],
                ),
              ),
              Text(m.time, style: AppText.caption()),
            ],
          ),
        );
      },
    );
  }
}
