import 'package:einblicke_app/core/widgets/custom_cupertino_button.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';
import 'package:flutter/cupertino.dart';

/// __Custom Cupertino Text Button__
///
/// A button that is styled like a Cupertino text button.
class CustomCupertinoTextButton extends StatelessWidget {
  const CustomCupertinoTextButton({
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
    return CustomCupertinoButton(
      disabledColor: disabledColor,
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: CustomCupertinoTheme.of(context).text.buttonLabel.copyWith(
              color: CustomCupertinoTheme.of(context).colors.primaryContrast,
            ),
      ),
    );
  }
}
