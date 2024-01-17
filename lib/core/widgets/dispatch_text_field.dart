import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:flutter/cupertino.dart';

class DispatchTextField extends StatelessWidget {
  const DispatchTextField({
    required this.hint,
    required this.onChanged,
    this.obscureText = false,
    super.key,
  });

  final String hint;
  final bool obscureText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: CupertinoTextField(
        placeholder: hint,
        obscureText: obscureText,
        style: IOSTheme.of(context).text.description,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: IOSTheme.of(context).colors.fieldColor,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
