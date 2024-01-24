import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_button.dart';
import 'package:flutter/cupertino.dart';

class DispatchTextButton extends StatelessWidget {
  const DispatchTextButton({
    super.key,
    required this.text,
    this.disabledColor,
    this.onPressed,
  });

  final String text;
  final Color? disabledColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DispatchButton(
      disabledColor: disabledColor,
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: IOSTheme.of(context).text.buttonLabel.copyWith(
              color: IOSTheme.of(context).colors.primaryContrast,
            ),
      ),
    );
  }
}
