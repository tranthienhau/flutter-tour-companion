import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common.dart';

/// Screen 06 - Match / activity detail. Duotone hero, logistics, what-to-bring,
/// a map preview, and actions. No bottom tab bar (pushed screen).
class ActivityDetailScreen extends StatelessWidget {
  final Activity activity;
  const ActivityDetailScreen({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16, right: 20),
              title: Text(activity.heroLabel ?? activity.title,
                  style: AppText.title().copyWith(color: Colors.white)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  const DecoratedBox(
                      decoration: BoxDecoration(gradient: AppColors.heroGradient)),
                  Center(
                    child: Icon(activity.icon,
                        size: 90,
                        color: Colors.white.withValues(alpha: 0.35)),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0x660E2126)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    _chip(Icons.calendar_today_outlined, 'Thu 26 Feb'),
                    const SizedBox(width: 10),
                    _chip(Icons.schedule, activity.time),
                  ],
                ),
                const SizedBox(height: 20),
                if (activity.meetingPoint != null)
                  SoftCard(
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                              color: AppColors.accentTint,
                              shape: BoxShape.circle),
                          child: const Icon(Icons.place_outlined,
                              color: AppColors.accentPressed),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Meeting point',
                                  style: AppText.caption()),
                              Text(activity.meetingPoint!,
                                  style: AppText.label()
                                      .copyWith(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (activity.section != null) ...[
                  const SizedBox(height: 12),
                  SoftCard(
                    child: Row(
                      children: [
                        const Icon(Icons.event_seat_outlined,
                            color: AppColors.accent),
                        const SizedBox(width: 14),
                        Text(activity.section!,
                            style: AppText.label()
                                .copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
                if (activity.bringList.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text('What to bring', style: AppText.title()),
                  const SizedBox(height: 10),
                  SoftCard(
                    child: Column(
                      children: [
                        for (final item in activity.bringList)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle_outline,
                                    color: AppColors.success, size: 20),
                                const SizedBox(width: 12),
                                Text(item, style: AppText.body()),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                _MapPreview(),
                const SizedBox(height: 16),
                const PrimaryButton(
                    label: 'Get directions', icon: Icons.directions_outlined),
                const SizedBox(height: 12),
                const SecondaryButton(
                    label: 'Add to calendar',
                    icon: Icons.calendar_month_outlined),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.pill)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(label,
              style: AppText.caption().copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _MapPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        height: 130,
        color: AppColors.surfaceAlt,
        child: Stack(
          children: [
            CustomPaint(size: Size.infinite, painter: _MiniMapPainter()),
            const Center(
              child: Icon(Icons.location_on,
                  color: AppColors.accent, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.border
      ..strokeWidth = 2;
    for (double x = 0; x < size.width; x += 34) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += 34) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
