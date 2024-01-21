import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CupertinoModalPopupRoute<T> extends PopupRoute<T> {
  /// A route that shows a modal iOS-style popup that slides up from the
  /// bottom of the screen.
  CupertinoModalPopupRoute({
    required this.builder,
    this.barrierLabel = 'Dismiss',
    this.barrierColor = kCupertinoModalBarrierColor,
    bool barrierDismissible = true,
    bool semanticsDismissible = false,
    super.filter,
    super.settings,
    this.anchorPoint,
  })  : _barrierDismissible = barrierDismissible,
        _semanticsDismissible = semanticsDismissible;

  /// A builder that builds the widget tree for the [CupertinoModalPopupRoute].
  ///
  /// The [builder] argument typically builds a [CupertinoActionSheet] widget.
  ///
  /// Content below the widget is dimmed with a [ModalBarrier]. The widget built
  /// by the [builder] does not share a context with the route it was originally
  /// built from. Use a [StatefulBuilder] or a custom [StatefulWidget] if the
  /// widget needs to update dynamically.
  final WidgetBuilder builder;

  final bool _barrierDismissible;

  final bool _semanticsDismissible;

  @override
  final String barrierLabel;

  @override
  final Color? barrierColor;

  @override
  bool get barrierDismissible => _barrierDismissible;

  @override
  bool get semanticsDismissible => _semanticsDismissible;

  @override
  Duration get transitionDuration => Duration(milliseconds: 335);

  Animation<double>? _animation;

  late Tween<Offset> _offsetTween;

  /// {@macro flutter.widgets.DisplayFeatureSubScreen.anchorPoint}
  final Offset? anchorPoint;

  @override
  Animation<double> createAnimation() {
    assert(_animation == null);
    _animation = CurvedAnimation(
      parent: super.createAnimation(),

      // These curves were initially measured from native iOS horizontal page
      // route animations and seemed to be a good match here as well.
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linearToEaseOut.flipped,
    );
    _offsetTween = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    );
    return _animation!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return CupertinoUserInterfaceLevel(
      data: CupertinoUserInterfaceLevelData.elevated,
      child: DisplayFeatureSubScreen(
        anchorPoint: anchorPoint,
        child: Builder(builder: builder),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    secondaryAnimation.drive(Tween(begin: Offset(1, 0), end: Offset(.4, 0)));
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionalTranslation(
        translation: _offsetTween.evaluate(_animation!),
        child: child,
      ),
    );
  }
}

Future<T?> showIOSModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  ImageFilter? filter,
  Color barrierColor = kCupertinoModalBarrierColor,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  bool semanticsDismissible = false,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) {
  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    CupertinoModalPopupRoute<T>(
      builder: builder,
      filter: filter,
      barrierColor: CupertinoDynamicColor.resolve(barrierColor, context),
      barrierDismissible: barrierDismissible,
      semanticsDismissible: semanticsDismissible,
      settings: routeSettings,
      anchorPoint: anchorPoint,
    ),
  );
}
