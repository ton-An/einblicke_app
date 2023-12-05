import 'package:dispatch_pi_app/core/dispatch_properties.dart';
import 'package:flutter/cupertino.dart';

class MediumGap extends StatelessWidget {
  const MediumGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: DispatchProperties.mediumPadding,
    );
  }
}
