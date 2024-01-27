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
      height: 44,
      child: CupertinoTextField(
        placeholder: hint,
        obscureText: obscureText,
        style: TextStyle(
          inherit: false,
          fontFamily: '.SF Pro Display',
          fontSize: 17.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.41,
          color: IOSTheme.of(context).colors.text,
        ),
        // placeholderStyle: IOSTheme.of(context).text.description.copyWith(
        //       color: IOSTheme.of(context).colors.hint,
        //     ),
        placeholderStyle: TextStyle(
          inherit: false,
          fontFamily: '.SF Pro Display',
          fontSize: 17.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.41,
          color: IOSTheme.of(context).colors.hint,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: IOSTheme.of(context).spacing.xxSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: IOSTheme.of(context).colors.fieldColor,
        ),
        onChanged: onChanged,
      ),
    );
  }
}