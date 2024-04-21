import 'package:einblicke_app/core/widgets/modal/ios_modal_page.dart';
import 'package:einblicke_app/core/widgets/modal/ios_route.dart';
import 'package:einblicke_app/core/widgets/modal/split_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sprung/sprung.dart';

class IOSModalRoute<T> extends PageRouteBuilder<T> {
  IOSModalRoute({
    required this.child,
    required IOSModalPage page,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          settings: page,
          opaque: false,
          transitionDuration: Duration(milliseconds: 650),
          reverseTransitionDuration: Duration(milliseconds: 850),
        );

  final Widget child;

  double dragDistance = 0;

  Curve animationCurve = Sprung.overDamped;
  Curve reverseAnimationCurve = Sprung.overDamped.flipped;

  IOSRoute? previousIosRoute;

  @override
  void onPopInvoked(bool didPop) {
    reverseAnimationCurve = animationCurve;
    previousIosRoute?.reverseAnimationCurve = animationCurve;
    controller!.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        previousIosRoute?.reverseAnimationCurve = Sprung.overDamped.flipped;
      }
    });

    super.onPopInvoked(didPop);
  }

  @override
  void didChangePrevious(Route? previousRoute) {
    if (previousRoute is IOSRoute) previousIosRoute = previousRoute;

    super.didChangePrevious(previousRoute);
  }

  void onDragStart(DragStartDetails details) {
    animationCurve = Curves.linear;
    previousIosRoute?.animationCurve = Curves.linear;
  }

  void onDragEnd(DragEndDetails details, BuildContext context) {
    if (dragDistance > MediaQuery.of(context).size.height / 2 ||
        details.velocity.pixelsPerSecond.distance > 2000) {
      animationCurve = Split(controller!.value,
          beginCurve: Sprung.overDamped.flipped, endCurve: Curves.linear);

      previousIosRoute?.animationCurve = Split(
        controller!.value,
        beginCurve: Sprung.overDamped.flipped,
        endCurve: Curves.linear,
      );

      controller!.animateTo(0).then((value) {
        previousIosRoute?.animationCurve = Sprung.overDamped;
        Navigator.pop(context);
      });
    } else {
      controller!.duration = Duration(milliseconds: 2000);
      animationCurve = Split(controller!.value,
          beginCurve: Curves.linear, endCurve: Sprung.overDamped);

      previousIosRoute?.animationCurve = Split(
        controller!.value,
        beginCurve: Curves.linear,
        endCurve: Sprung.overDamped,
      );

      controller!.forward().then((value) {
        animationCurve = Sprung.overDamped;
        previousIosRoute?.animationCurve = Sprung.overDamped;
        dragDistance = 0;
        controller!.duration = transitionDuration;
      });
    }
  }

  void onDragUpdate(DragUpdateDetails details, BuildContext context) {
    dragDistance += details.delta.dy;
    double newValue =
        details.primaryDelta! / MediaQuery.of(context).size.height;
    controller!.value -= newValue;
    // previousIosRoute?.controller!.value -= newValue;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10 + MediaQuery.of(context).padding.top,
      ),
      child: GestureDetector(
        onVerticalDragStart: onDragStart,
        onVerticalDragUpdate: (DragUpdateDetails details) =>
            onDragUpdate(details, context),
        onVerticalDragEnd: (DragEndDetails details) =>
            onDragEnd(details, context),
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
        reverseCurve: reverseAnimationCurve);
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(curvedAnimation),
      child: child,
    );
  }
}
