import 'package:einblicke_app/core/theme/custom_cupertino_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

class XXMediumGap extends StatelessWidget {
  const XXMediumGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Gap(CustomCupertinoTheme.of(context).spacing.xxMedium);
  }
}
