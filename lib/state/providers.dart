import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_data.dart';
import '../models/models.dart';

/// The tour group unlocked by a valid code. Null until the user signs in.
final tourProvider = StateProvider<TourGroup?>((ref) => null);

/// Offline itinerary download toggle (set on the welcome screen, shown as the
/// "Offline ready" pill across the app).
final offlineProvider = StateProvider<bool>((ref) => true);

/// Push notification opt-in (profile setting).
final notificationsProvider = StateProvider<bool>((ref) => true);

/// Attempt to unlock a tour with a code. Returns true on success and stores the
/// matched group in [tourProvider].
bool tryUnlock(WidgetRef ref, String code) {
  final group = kTourCodes[code.trim().toUpperCase()];
  if (group == null) return false;
  ref.read(tourProvider.notifier).state = group;
  return true;
}

/// Updates feed with unread tracking.
class UpdatesNotifier extends StateNotifier<List<UpdateItem>> {
  UpdatesNotifier() : super(List.of(kUpdates));

  int get unread => state.where((u) => !u.read).length;

  void markAllRead() {
    state = [
      for (final u in state)
        UpdateItem(
          id: u.id,
          title: u.title,
          body: u.body,
          timeAgo: u.timeAgo,
          staffName: u.staffName,
          pinned: u.pinned,
          read: true,
        )
    ];
  }

  void clearAll() => state = [];
}

final updatesProvider =
    StateNotifierProvider<UpdatesNotifier, List<UpdateItem>>(
        (ref) => UpdatesNotifier());

final unreadCountProvider = Provider<int>((ref) {
  final list = ref.watch(updatesProvider);
  return list.where((u) => !u.read).length;
});
