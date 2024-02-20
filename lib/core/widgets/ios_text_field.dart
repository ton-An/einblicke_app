import 'package:einblicke_app/core/ios_properties.dart';
import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:flutter/cupertino.dart';

/*
  To-Dos:
  - [ ] Check spacing and border radius
*/

/// __IOS Text Field__
///
/// A text field that is styled like an iOS text field.
class IOSTextField extends StatelessWidget {
  const IOSTextField({
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
        style: IOSTheme.of(context).text.textField,
        placeholderStyle: IOSTheme.of(context).text.textField.copyWith(
              color: IOSTheme.of(context).colors.hint,
            ),
        padding: EdgeInsets.symmetric(
            horizontal: IOSTheme.of(context).spacing.medium + 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IOSProperties.fieldBorderRadius),
          color: IOSTheme.of(context).colors.fieldColor,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
