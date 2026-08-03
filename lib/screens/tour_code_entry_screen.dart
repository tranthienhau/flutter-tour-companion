import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../state/providers.dart';
import '../widgets/common.dart';
import 'welcome_group_screen.dart';

/// Screen 01 - Tour code entry. Soft accent->support gradient hero, tour crest,
/// a segmented code input pre-filled with a valid code so the flow is demoable.
class TourCodeEntryScreen extends ConsumerStatefulWidget {
  const TourCodeEntryScreen({super.key});

  @override
  ConsumerState<TourCodeEntryScreen> createState() =>
      _TourCodeEntryScreenState();
}

class _TourCodeEntryScreenState extends ConsumerState<TourCodeEntryScreen> {
  final _controller = TextEditingController(text: 'ASH-42K');
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _continue() {
    final ok = tryUnlock(ref, _controller.text);
    if (!ok) {
      setState(() => _error = 'That code was not recognised. Try ASH-42K.');
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const WelcomeGroupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Gradient hero with crest
          Container(
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(gradient: AppColors.heroGradient),
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.sports_cricket,
                        color: AppColors.accent, size: 46),
                  ),
                  const SizedBox(height: 16),
                  Text('Ashes Tour AU',
                      style: AppText.title().copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -32),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SoftCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Enter your tour code', style: AppText.display()),
                      const SizedBox(height: 6),
                      Text("Unlock your group's itinerary",
                          style: AppText.body()
                              .copyWith(color: AppColors.textSecondary)),
                      const SizedBox(height: 24),
                      _CodeField(controller: _controller, error: _error != null),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                              _error == null
                                  ? Icons.info_outline
                                  : Icons.error_outline,
                              size: 15,
                              color: _error == null
                                  ? AppColors.textTertiary
                                  : AppColors.danger),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                                _error ??
                                    'Find your code in your welcome email',
                                style: AppText.caption().copyWith(
                                    color: _error == null
                                        ? AppColors.textTertiary
                                        : AppColors.danger)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(label: 'Continue', onPressed: _continue),
                      const SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Need help?',
                              style: AppText.label()
                                  .copyWith(color: AppColors.accent)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeField extends StatelessWidget {
  final TextEditingController controller;
  final bool error;
  const _CodeField({required this.controller, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border.all(
            color: error ? AppColors.danger : AppColors.border, width: 1.5),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        textCapitalization: TextCapitalization.characters,
        style: AppText.display().copyWith(fontSize: 26, letterSpacing: 6),
        inputFormatters: [
          UpperCaseFormatter(),
          LengthLimitingTextInputFormatter(9),
        ],
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18),
          hintText: 'ABC-000',
        ),
      ),
    );
  }
}

class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}
