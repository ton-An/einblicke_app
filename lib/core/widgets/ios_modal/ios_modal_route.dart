import 'package:einblicke_app/core/widgets/ios_modal/ios_modal_page.dart';
import 'package:einblicke_app/core/widgets/ios_modal/split_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sprung/sprung.dart';

/*
  To-Do:
    - [ ] Add the proper shadow
    - [ ] Add ability to drag modal up a bit more than when at full height
    - [ ] _arePopConditionsMet should use the page size and not the screen size
*/

/// __IOS Modal Route__
///
/// {@template ios_modal_route}
/// A Route that has the properties of a modal on IOS.
///
/// It uses physics-based animations, a shadow and the ability to drag the modal to dismiss it.
/// {@endtemplate}
class IOSModalRoute<T> extends PageRouteBuilder<T> {
  IOSModalRoute({
    required this.child,
    required IOSModalPage page,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          settings: page,
          opaque: false,
          transitionDuration: const Duration(milliseconds: 560),
          reverseTransitionDuration: const Duration(milliseconds: 560),
        );

  final Widget child;

  static final Curve _curve = Sprung(32);

  double _dragDistance = 0;

  Curve animationCurve = _curve;
  Curve reverseAnimationCurve = _curve.flipped;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10 + MediaQuery.of(context).padding.top,
      ),
      child: GestureDetector(
        onVerticalDragStart: _onDragStart,
        onVerticalDragUpdate: (DragUpdateDetails details) =>
            _onDragUpdate(details, context),
        onVerticalDragEnd: (DragEndDetails details) =>
            _onDragEnd(details, context),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 16,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: animationCurve,
      reverseCurve: reverseAnimationCurve,
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(curvedAnimation),
      child: IgnorePointer(
        ignoring: controller!.isAnimating,
        child: child,
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    animationCurve = Curves.linear;
  }

  void _onDragUpdate(DragUpdateDetails details, BuildContext context) {
    _dragDistance += details.delta.dy;
    controller!.value -=
        details.primaryDelta! / MediaQuery.of(context).size.height;
  }

  void _onDragEnd(DragEndDetails details, BuildContext context) {
    if (_arePopConditionsMet(context, details)) {
      animationCurve = Split(
        controller!.value,
        beginCurve: _curve.flipped,
        endCurve: Curves.linear,
      );

      controller!.animateTo(0).then((value) {
        Navigator.pop(context);
      });
    } else {
      controller!.duration = const Duration(milliseconds: 2000);

      animationCurve = Split(
        controller!.value,
        beginCurve: Curves.linear,
        endCurve: _curve,
      );

      controller!.forward().then((value) {
        animationCurve = _curve;
        _dragDistance = 0;
        controller!.duration = transitionDuration;
      });
    }
  }

  /// Checks if the modal should be popped based on the drag distance and velocity
  bool _arePopConditionsMet(BuildContext context, DragEndDetails details) {
    return _dragDistance > MediaQuery.of(context).size.height / 2 ||
        details.velocity.pixelsPerSecond.distance > 2000;
  }
}
