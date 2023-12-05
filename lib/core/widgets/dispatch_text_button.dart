import 'package:flutter/cupertino.dart';

class DispatchTextButton extends StatelessWidget {
  const DispatchTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
        onPressed: onPressed,
        child: Text(
          text,
          style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(
                color: CupertinoColors.white,
              ),
        ));
  }
}
