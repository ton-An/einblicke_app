import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class XXSmallGap extends StatelessWidget {
  const XXSmallGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Gap(IOSTheme.of(context).spacing.xxSmall);
  }
}
