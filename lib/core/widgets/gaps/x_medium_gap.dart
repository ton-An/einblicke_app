import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:flutter/cupertino.dart';

class XMediumGap extends StatelessWidget {
  const XMediumGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: IOSTheme.of(context).spacing.xMedium,
    );
  }
}
