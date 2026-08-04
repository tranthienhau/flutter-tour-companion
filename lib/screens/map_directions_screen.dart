import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../widgets/common.dart';

/// Screen 08 - Maps and directions. A stylised full-bleed map with tour pins and
/// a bottom sheet for the selected point. Map tab.
class MapDirectionsScreen extends ConsumerStatefulWidget {
  const MapDirectionsScreen({super.key});

  @override
  ConsumerState<MapDirectionsScreen> createState() =>
      _MapDirectionsScreenState();
}

class _MapDirectionsScreenState extends ConsumerState<MapDirectionsScreen> {
  int _selected = 1; // MCG
  int _seg = 0;

  @override
  Widget build(BuildContext context) {
    final point = kMapPoints[_selected];

    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          // Map surface with grid + roads + pins
          Positioned.fill(
            child: CustomPaint(painter: _MapPainter()),
          ),
          // Pins
          LayoutBuilder(builder: (context, c) {
            return Stack(
              children: [
                for (int i = 0; i < kMapPoints.length; i++)
                  Positioned(
                    left: kMapPoints[i].position.dx * c.maxWidth - 22,
                    top: kMapPoints[i].position.dy * c.maxHeight - 44,
                    child: _Pin(
                      point: kMapPoints[i],
                      selected: i == _selected,
                      onTap: () => setState(() => _selected = i),
                    ),
                  ),
              ],
            );
          }),
          // Segmented control floating on top
          Positioned(
            top: 12,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                boxShadow: kCardShadow,
              ),
              child: Row(
                children: [
                  for (final (i, label) in ['Today', 'All locations'].indexed)
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _seg = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _seg == i
                                ? AppColors.accentTint
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Text(label,
                              textAlign: TextAlign.center,
                              style: AppText.label().copyWith(
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
          // Bottom sheet card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                boxShadow: kCardShadow,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                            color: AppColors.accentTint,
                            shape: BoxShape.circle),
                        child: Icon(point.icon,
                            color: AppColors.accentPressed),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(point.name, style: AppText.title()),
                            Text('${point.distance} - ${point.eta}',
                                style: AppText.caption()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const PrimaryButton(
                      label: 'Directions',
                      icon: Icons.directions_outlined),
                  const SizedBox(height: 14),
                  Text('Nearby tour points', style: AppText.caption()),
                  const SizedBox(height: 8),
                  for (int i = 0; i < kMapPoints.length; i++)
                    if (i != _selected)
                      InkWell(
                        onTap: () => setState(() => _selected = i),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Icon(kMapPoints[i].icon,
                                  size: 18, color: AppColors.textSecondary),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Text(kMapPoints[i].name,
                                      style: AppText.label())),
                              Text(kMapPoints[i].distance,
                                  style: AppText.caption()),
                            ],
                          ),
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
}

class _Pin extends StatelessWidget {
  final MapPoint point;
  final bool selected;
  final VoidCallback onTap;
  const _Pin(
      {required this.point, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: selected ? AppColors.accent : AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.accent, width: 2),
              boxShadow: kCardShadow,
            ),
            child: Icon(point.icon,
                size: 18,
                color: selected ? Colors.white : AppColors.accent),
          ),
          Transform.translate(
            offset: const Offset(0, -3),
            child: const Icon(Icons.arrow_drop_down,
                color: AppColors.accent, size: 20),
          ),
        ],
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Offset.zero & size, Paint()..color = const Color(0xFFE6F1F3));
    final block = Paint()..color = AppColors.surface;
    final road = Paint()
      ..color = const Color(0xFFDCE9EC)
      ..strokeWidth = 14;
    // roads
    for (double y = 60; y < size.height; y += 150) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), road);
    }
    for (double x = 50; x < size.width; x += 140) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), road);
    }
    // building blocks
    final r = RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 46, 34), const Radius.circular(6));
    for (double y = 80; y < size.height; y += 150) {
      for (double x = 70; x < size.width; x += 140) {
        canvas.save();
        canvas.translate(x, y);
        canvas.drawRRect(r, block);
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
