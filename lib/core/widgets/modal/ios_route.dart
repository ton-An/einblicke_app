import 'package:einblicke_app/core/widgets/modal/ios_modal_route.dart';
import 'package:einblicke_app/core/widgets/modal/ios_page.dart';
import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

class IOSRoute<T> extends PageRouteBuilder<T> {
  IOSRoute({
    required this.child,
    required IOSPage<T> page,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          settings: page,
          transitionDuration: Duration(milliseconds: 650),
          reverseTransitionDuration: Duration(milliseconds: 850),
        );

  final Widget child;

  Curve animationCurve = Sprung.overDamped;
  Curve reverseAnimationCurve = Sprung.overDamped.flipped;

  IOSModalRoute? nextModalRoute;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  void didChangeNext(Route? nextRoute) {
    print(nextRoute);
    print(nextModalRoute);
    if (nextModalRoute != null && nextModalRoute!.controller!.isAnimating) {
      animationCurve = reverseAnimationCurve;
      print("object");
      if (nextRoute is IOSModalRoute) {
        nextRoute.controller!.addStatusListener((status) {
          if (status == AnimationStatus.completed && nextModalRoute != null) {
            animationCurve = Sprung.overDamped;
          }
        });
      }
    }

    if (nextRoute is IOSModalRoute) nextModalRoute = nextRoute;
    super.didChangeNext(nextRoute);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    CurvedAnimation secondaryCurvedAnimation = CurvedAnimation(
      parent: secondaryAnimation,
      curve: animationCurve,
      reverseCurve: reverseAnimationCurve,
    );
    final secondaryAnimationValue = secondaryCurvedAnimation.value;
    final scalething = 16 / MediaQuery.of(context).size.width;

    return Transform.translate(
      offset: Offset(
          0, secondaryAnimationValue * MediaQuery.of(context).padding.top),
      child: Transform.scale(
        scale: 1 - secondaryAnimationValue * scalething * 2,
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(47.33 - secondaryAnimationValue * 39.33),
          child: child,
        ),
      ),
    );
  }
}
