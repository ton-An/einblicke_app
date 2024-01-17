import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:flutter/cupertino.dart';

class SmallerGap extends StatelessWidget {
  const SmallerGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: IOSTheme.of(context).spacing.xTiny);
  }
}
