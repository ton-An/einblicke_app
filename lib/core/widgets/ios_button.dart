import 'package:dispatch_pi_app/core/ios_properties.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:flutter/cupertino.dart';

/// __IOS Button__
///
/// A button that is styled like an iOS button.
class IOSButton extends StatelessWidget {
  const IOSButton({
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
      disabledColor:
          disabledColor ?? IOSTheme.of(context).colors.disabledButton,
      borderRadius: BorderRadius.circular(
        IOSProperties.buttonBorderRadius,
      ),
      minSize: 50,
      onPressed: onPressed,
      child: child,
    );
  }
}
