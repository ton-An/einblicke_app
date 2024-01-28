import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/core/widgets/ios_button.dart';
import 'package:flutter/cupertino.dart';

/// __IOS Text Button__
///
/// A button that is styled like an iOS text button.
class IOSTextButton extends StatelessWidget {
  const IOSTextButton({
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
    return IOSButton(
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
