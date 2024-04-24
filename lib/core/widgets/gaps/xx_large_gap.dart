import 'package:einblicke_app/core/theme/custom_cupertino_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class XXLargeGap extends StatelessWidget {
  const XXLargeGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Gap(CustomCupertinoTheme.of(context).spacing.xxLarge);
  }
}
