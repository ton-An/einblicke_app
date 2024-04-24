import 'package:einblicke_app/core/widgets/custom_cupertino_modal/custom_cupertino_modal_route.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_modal/custom_cupertino_page.dart';
import 'package:flutter/material.dart';

/*
  To-Do:
    - [ ] Add documentation
    - [ ] Calculate the border radius (at 0.0 for the secondary animation) based on the phone model
    - [ ] Prevent weird behaviour if the nextRoute is not an [CustomCupertinoModalRoute]
*/

/// __Custom Cupertino Route__
///
/// {@template custom_cupertino_route}
/// A route with no special functions, except for when it is the previous route of a modal.
/// In that case it will scale down, move down on the y-axis and have a border radius applied.
/// {@endtemplate}
class CustomCupertinoRoute<T> extends PageRouteBuilder<T> {
  CustomCupertinoRoute({
    required this.child,
    required CustomCupertinoPage<T> page,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          settings: page,
          opaque: false,
        );

  final Widget child;

  CustomCupertinoModalRoute? nextModalRoute;

  @override
  void didChangeNext(Route? nextRoute) {
    if (nextRoute is CustomCupertinoModalRoute) {
      nextModalRoute = nextRoute;
    } else {
      nextModalRoute = null;
    }

    super.didChangeNext(nextRoute);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    CurvedAnimation secondaryCurvedAnimation = CurvedAnimation(
      parent: secondaryAnimation,
      curve: nextModalRoute?.animationCurve ?? Curves.bounceInOut,
      reverseCurve: nextModalRoute?.reverseAnimationCurve ?? Curves.bounceInOut,
    );

    return IgnorePointer(
      ignoring: nextModalRoute?.controller?.isAnimating ?? false,
      child: Transform.translate(
        offset: Offset(
            0, _calculateOffset(context, secondaryCurvedAnimation.value)),
        child: Transform.scale(
          scale: _calculateScaleFactor(context, secondaryCurvedAnimation.value),
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius:
                _calculateBorderRadius(secondaryCurvedAnimation.value, context),
            child: child,
          ),
        ),
      ),
    );
  }

  /// On IOS, the previous route of a modal has a border radius set by the device's screen corner radius.
  ///
  /// This is only apparent when the modal is animating. The border radius at 0.0 and 1.0 is the same
  /// (at 0.0 it technically is not but looks the same to the user).
  BorderRadius _calculateBorderRadius(
      double secondaryAnimationValue, BuildContext context) {
    return BorderRadius.circular(47.33 - secondaryAnimationValue * 39.33);
  }

  /// On IOS, the previous route of a modal is scaled down to [1 - an 8th of the screen width]
  double _calculateScaleFactor(
          BuildContext context, double secondaryAnimationValue) =>
      1 - secondaryAnimationValue * 16 / MediaQuery.of(context).size.width * 2;

  /// On IOS, the previous route of a modal is offset by the height of the status bar
  double _calculateOffset(
          BuildContext context, double secondaryAnimationValue) =>
      secondaryAnimationValue * MediaQuery.of(context).padding.top;
}
