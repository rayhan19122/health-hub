import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Custom OTP input widget with individual digit boxes.
class OtpInputField extends StatefulWidget {
  const OtpInputField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
  });

  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());

    // Auto-fill first 4 digits for demo
    final demoDigits = ['4', '7', '2', '9'];
    for (int i = 0; i < demoDigits.length && i < widget.length; i++) {
      _controllers[i].text = demoDigits[i];
    }

    // Focus the 5th box
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (demoDigits.length < widget.length) {
        _focusNodes[demoDigits.length].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _currentOtp => _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.length == 1 && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    final otp = _currentOtp;
    widget.onChanged?.call(otp);

    if (otp.length == widget.length) {
      widget.onCompleted?.call(otp);
    }
  }

  void _onBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
      widget.onChanged?.call(_currentOtp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) {
        final hasValue = _controllers[i].text.isNotEmpty;

        return Padding(
          padding: EdgeInsets.only(right: i < widget.length - 1 ? 10 : 0),
          child: SizedBox(
            width: 48,
            height: 56,
            child: KeyboardListener(
              focusNode: FocusNode(), // wrapper node
              onKeyEvent: (event) {
                if (event is KeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.backspace) {
                  _onBackspace(i);
                }
              },
              child: TextField(
                controller: _controllers[i],
                focusNode: _focusNodes[i],
                maxLength: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
                onChanged: (v) => _onChanged(i, v),
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    borderSide: BorderSide(
                      color: hasValue ? AppColors.primary : theme.colorScheme.outline,
                      width: hasValue ? 2 : 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    borderSide: BorderSide(
                      color: hasValue ? AppColors.primary : theme.colorScheme.outline,
                      width: hasValue ? 2 : 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    borderSide: const BorderSide(color: AppColors.primary, width: 2),
                  ),
                  filled: true,
                  fillColor: isDark ? AppColors.inputBgDark : AppColors.inputBgLight,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
