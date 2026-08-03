import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Pill primary button (accent fill).
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  const PrimaryButton(
      {super.key, required this.label, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.accent,
          disabledBackgroundColor: AppColors.accentTint,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.pill)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
            Text(label,
                style: AppText.label().copyWith(
                    color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

/// Pill secondary button (accent outline).
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  const SecondaryButton(
      {super.key, required this.label, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accent,
          side: const BorderSide(color: AppColors.accent, width: 1.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.pill)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
            Text(label,
                style: AppText.label()
                    .copyWith(color: AppColors.accent, fontWeight: FontWeight.w600, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

/// White card with 20px radius and soft shadow.
class SoftCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  const SoftCard(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(16),
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: kCardShadow,
      ),
      child: child,
    );
  }
}

/// Small pill chip (selectable).
class PillChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  const PillChip(
      {super.key, required this.label, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentTint : AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(label,
            style: AppText.label().copyWith(
                color: selected ? AppColors.accentPressed : AppColors.textSecondary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500)),
      ),
    );
  }
}

/// The "Offline ready" pill used in top bars.
class OfflinePill extends StatelessWidget {
  const OfflinePill({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.accentTint,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_done_outlined,
              size: 14, color: AppColors.accentPressed),
          const SizedBox(width: 4),
          Text('Offline ready',
              style: AppText.caption().copyWith(
                  color: AppColors.accentPressed, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

/// Group chip (e.g. "Group C").
class GroupChip extends StatelessWidget {
  final String label;
  const GroupChip(this.label, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(label,
          style: AppText.caption()
              .copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
    );
  }
}

/// Top app bar: tour name + group chip + offline pill. Used inside CustomScrollView
/// bodies as a plain header row.
class TourHeader extends StatelessWidget {
  final String tourName;
  final String groupLabel;
  final bool offline;
  const TourHeader(
      {super.key,
      required this.tourName,
      required this.groupLabel,
      this.offline = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.sports_cricket, color: AppColors.accent, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(tourName,
              style: AppText.title().copyWith(color: AppColors.accent),
              overflow: TextOverflow.ellipsis),
        ),
        GroupChip(groupLabel),
        if (offline) ...[const SizedBox(width: 8), const OfflinePill()],
      ],
    );
  }
}
