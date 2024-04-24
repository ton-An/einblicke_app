import 'package:einblicke_app/core/widgets/custom_cupertino_modal/custom_cupertino_modal_route.dart';
import 'package:flutter/cupertino.dart';

/// __Custom Cupertino Modal Page__
///
/// {@macro custom_cupertino_modal_route}
class CustomCupertinoModalPage<T> extends Page<T> {
  const CustomCupertinoModalPage({
    required this.child,
  });

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return CustomCupertinoModalRoute<T>(child: child, page: this);
  }
}
