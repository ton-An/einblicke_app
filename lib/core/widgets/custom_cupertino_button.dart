import 'package:einblicke_app/core/custom_cupertino_properties.dart';
import 'package:einblicke_app/core/theme/custom_cupertino_theme.dart';
import 'package:flutter/cupertino.dart';

/* 
  To-Dos:
  - [ ] Add transitions (maybe)
  - [ ] Add ability to change button color
  - [ ] Add ability to enable/disable button
*/

/// __Custom Cupertino Button__
///
/// A button that is styled like a Cupertino button.
class CustomCupertinoButton extends StatelessWidget {
  const CustomCupertinoButton({
    super.key,
    required this.child,
    this.disabledColor,
    this.onPressed,
  });

  final Widget child;
  final Color? disabledColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      disabledColor: disabledColor ??
          CustomCupertinoTheme.of(context).colors.disabledButton,
      borderRadius: BorderRadius.circular(
        CustomCupertinoProperties.buttonBorderRadius,
      ),
      minSize: 50,
      onPressed: onPressed,
      child: child,
    );
  }
}
