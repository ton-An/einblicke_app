import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';
import 'package:flutter/cupertino.dart';

/*
  To-Dos:
  - [ ] Check spacing and border radius
*/

/// __Custom Cupertino Text Field__
///
/// A text field that is styled like a Cupertino text field.
class CustomCupertinoTextField extends StatelessWidget {
  const CustomCupertinoTextField({
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
        style: obscureText
            ? const TextStyle(
                inherit: false,
                fontFamily: '.SF Pro Display',
                fontSize: 23.0,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.1,
                color: CupertinoColors.label)
            : CustomCupertinoTheme.of(context).text.textField,
        placeholderStyle:
            CustomCupertinoTheme.of(context).text.textField.copyWith(
                  color: CustomCupertinoTheme.of(context).colors.hint,
                ),
        cursorHeight: 20,
        padding: EdgeInsets.symmetric(
            horizontal: CustomCupertinoTheme.of(context).spacing.medium + 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              CustomCupertinoProperties.fieldBorderRadius),
          color: CustomCupertinoTheme.of(context).colors.fieldColor,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
