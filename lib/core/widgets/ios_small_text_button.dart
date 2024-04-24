import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:flutter/material.dart';

class IOSSmallTextButton extends StatelessWidget {
  const IOSSmallTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(IOSTheme.of(context).spacing.xSmall),
        child: Text(
          text,
          style: IOSTheme.of(context)
              .text
              .body
              .copyWith(color: IOSTheme.of(context).colors.primary),
        ),
      ),
    );
  }
}
