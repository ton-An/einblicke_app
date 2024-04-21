import 'package:einblicke_app/core/widgets/modal/ios_modal_route.dart';
import 'package:flutter/cupertino.dart';

class IOSModalPage<T> extends Page<T> {
  const IOSModalPage({
    required this.child,
  });

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return IOSModalRoute<T>(child: child, page: this);
  }
}
