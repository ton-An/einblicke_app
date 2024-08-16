import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';
import 'package:flutter/material.dart';

class CustomCupertinoSmallTextButton extends StatelessWidget {
  const CustomCupertinoSmallTextButton({
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
        padding:
            EdgeInsets.all(CustomCupertinoTheme.of(context).spacing.xSmall),
        child: Text(
          text,
          style: CustomCupertinoTheme.of(context)
              .text
              .body
              .copyWith(color: CustomCupertinoTheme.of(context).colors.primary),
        ),
      ),
    );
  }
}
