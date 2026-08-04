import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common.dart';
import 'activity_detail_screen.dart';

/// Screen 05 - Single day detail. A full vertical timeline of the day's items
/// with a highlighted meeting-point callout. No bottom tab bar (pushed screen).
class DayDetailScreen extends StatelessWidget {
  final DayPlan day;
  const DayDetailScreen({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final meeting =
        day.activities.where((a) => a.meetingPoint != null).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Day ${day.dayNumber}', style: AppText.title()),
            Text('${day.city}, ${day.dateLabel}', style: AppText.caption()),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          if (meeting.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.accentTint,
                borderRadius: BorderRadius.circular(AppRadius.control),
              ),
              child: Row(
                children: [
                  const Icon(Icons.push_pin_outlined,
                      color: AppColors.accentPressed, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Meeting point',
                            style: AppText.caption().copyWith(
                                color: AppColors.accentPressed,
                                fontWeight: FontWeight.w700)),
                        Text(meeting.first.meetingPoint!,
                            style: AppText.label()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SoftCard(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                for (int i = 0; i < day.activities.length; i++)
                  _Row(
                    a: day.activities[i],
                    first: i == 0,
                    last: i == day.activities.length - 1,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            ActivityDetailScreen(activity: day.activities[i]))),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final Activity a;
  final bool first;
  final bool last;
  final VoidCallback onTap;
  const _Row(
      {required this.a,
      required this.first,
      required this.last,
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
                    height: 14,
                    color: first ? Colors.transparent : AppColors.border),
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                      color: AppColors.accentTint, shape: BoxShape.circle),
                  child: Icon(a.icon,
                      size: 16, color: AppColors.accentPressed),
                ),
                Expanded(
                    child: Container(
                        width: 2,
                        color: last ? Colors.transparent : AppColors.border)),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  children: [
                    SizedBox(
                        width: 62,
                        child: Text(a.time,
                            style: AppText.caption().copyWith(
                                fontWeight: FontWeight.w600))),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a.title,
                              style: AppText.label()
                                  .copyWith(fontWeight: FontWeight.w600)),
                          Text(a.venue, style: AppText.caption()),
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
