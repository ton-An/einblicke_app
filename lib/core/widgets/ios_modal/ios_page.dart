import 'package:einblicke_app/core/widgets/ios_modal/ios_route.dart';
import 'package:flutter/cupertino.dart';

/// __IOS Page__
///
/// {@macro ios_route}
class IOSPage<T> extends Page<T> {
  const IOSPage({
    required this.child,
  });

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return IOSRoute(child: child, page: this);
  }
}
