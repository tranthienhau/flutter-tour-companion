import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../state/providers.dart';
import 'home_screen.dart';
import 'itinerary_screen.dart';
import 'map_directions_screen.dart';
import 'updates_screen.dart';
import 'profile_screen.dart';

/// The tabbed shell. The bottom bar is the single shared nav concept: exactly
/// five tabs (Home, Itinerary, Map, Updates, Profile) reused verbatim.
class HomeShell extends ConsumerStatefulWidget {
  final int initialIndex;
  const HomeShell({super.key, this.initialIndex = 0});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  late int _index = widget.initialIndex;

  static const _pages = [
    HomeScreen(),
    ItineraryScreen(),
    MapDirectionsScreen(),
    UpdatesScreen(),
    ProfileScreen(),
  ];

  void _select(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final unread = ref.watch(unreadCountProvider);

    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 62,
            child: Row(
              children: [
                _tab(0, Icons.home_outlined, Icons.home, 'Home'),
                _tab(1, Icons.calendar_month_outlined, Icons.calendar_month,
                    'Itinerary'),
                _tab(2, Icons.location_on_outlined, Icons.location_on, 'Map'),
                _tab(3, Icons.notifications_outlined, Icons.notifications,
                    'Updates',
                    badge: unread),
                _tab(4, Icons.person_outline, Icons.person, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tab(int i, IconData icon, IconData active, String label,
      {int badge = 0}) {
    final selected = _index == i;
    final color = selected ? AppColors.accent : AppColors.textTertiary;
    return Expanded(
      child: InkWell(
        onTap: () => _select(i),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(selected ? active : icon, color: color, size: 24),
                if (badge > 0)
                  Positioned(
                    right: -6,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      constraints:
                          const BoxConstraints(minWidth: 16, minHeight: 16),
                      decoration: const BoxDecoration(
                          color: AppColors.support, shape: BoxShape.circle),
                      child: Text('$badge',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(label,
                style: AppText.caption().copyWith(
                    fontSize: 11,
                    color: color,
                    fontWeight:
                        selected ? FontWeight.w700 : FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
