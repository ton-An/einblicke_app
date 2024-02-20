import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class XTinyGap extends StatelessWidget {
  const XTinyGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Gap(IOSTheme.of(context).spacing.xTiny);
  }
}
