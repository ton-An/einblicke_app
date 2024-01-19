import 'package:dispatch_pi_app/core/dispatch_properties.dart';
import 'package:flutter/cupertino.dart';

class DispatchButton extends StatelessWidget {
  const DispatchButton({
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
      disabledColor: disabledColor ?? CupertinoColors.quaternarySystemFill,
      borderRadius: BorderRadius.circular(
        DispatchProperties.buttonBorderRadius,
      ),
      minSize: 51,
      // padding: EdgeInsets.symmetric(
      //   vertical: IOSTheme.of(context).spacing.medium,
      // ),
      child: child,
      onPressed: onPressed,
    );
  }
}
