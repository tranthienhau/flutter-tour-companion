import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../state/providers.dart';
import '../widgets/common.dart';

/// Screen 09 / 10 - Updates feed with a pinned announcement and an empty state.
class UpdatesScreen extends ConsumerWidget {
  const UpdatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updates = ref.watch(updatesProvider);
    final unread = ref.watch(unreadCountProvider);

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
            child: Row(
              children: [
                Text('Updates', style: AppText.display().copyWith(fontSize: 26)),
                const SizedBox(width: 10),
                if (unread > 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                        color: AppColors.support,
                        borderRadius: BorderRadius.circular(AppRadius.pill)),
                    child: Text('$unread new',
                        style: AppText.caption().copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                const Spacer(),
                if (updates.isNotEmpty)
                  TextButton(
                    onPressed: () =>
                        ref.read(updatesProvider.notifier).markAllRead(),
                    child: Text('Mark read',
                        style:
                            AppText.label().copyWith(color: AppColors.accent)),
                  ),
              ],
            ),
          ),
          Expanded(
            child: updates.isEmpty
                ? const _EmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    itemCount: updates.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => _UpdateCard(updates[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _UpdateCard extends StatelessWidget {
  final UpdateItem u;
  const _UpdateCard(this.u);

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      color: u.pinned ? AppColors.accentTint : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: AppColors.accent, shape: BoxShape.circle),
            child: const Icon(Icons.support_agent, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (u.pinned) ...[
                      const Icon(Icons.push_pin,
                          size: 14, color: AppColors.accentPressed),
                      const SizedBox(width: 4),
                    ],
                    Expanded(
                      child: Text(u.title,
                          style: AppText.label()
                              .copyWith(fontWeight: FontWeight.w700)),
                    ),
                    if (!u.read)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: AppColors.support, shape: BoxShape.circle),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(u.body,
                    style: AppText.body()
                        .copyWith(fontSize: 14, color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(u.staffName,
                        style: AppText.caption()
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    Text('- ${u.timeAgo}', style: AppText.caption()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
                color: AppColors.surfaceAlt, shape: BoxShape.circle),
            child: const Icon(Icons.notifications_active_outlined,
                size: 76, color: AppColors.accent),
          ),
          const SizedBox(height: 24),
          Text("You're all caught up", style: AppText.display().copyWith(fontSize: 24)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
                'New announcements from your tour staff will appear here',
                textAlign: TextAlign.center,
                style: AppText.body().copyWith(color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }
}
