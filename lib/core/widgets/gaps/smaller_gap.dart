import 'package:dispatch_pi_app/core/dispatch_properties.dart';
import 'package:flutter/cupertino.dart';

class SmallerGap extends StatelessWidget {
  const SmallerGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: DispatchProperties.smallerPadding,
    );
  }
}
