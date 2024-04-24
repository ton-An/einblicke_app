import 'package:einblicke_app/core/widgets/custom_cupertino_modal/custom_cupertino_route.dart';
import 'package:flutter/cupertino.dart';

/// __Custom Cupertino Page__
///
/// {@macro custom_cupertino_route}
class CustomCupertinoPage<T> extends Page<T> {
  const CustomCupertinoPage({
    required this.child,
  });

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return CustomCupertinoRoute(child: child, page: this);
  }
}
