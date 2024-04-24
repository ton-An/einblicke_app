import 'package:apple_product_name/apple_product_name.dart';
import 'package:device_info_plus/device_info_plus.dart';
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

  double? screenCornerRadius;
  CustomCupertinoModalRoute? nextModalRoute;

  @override
  void install() {
    _setScreenCornerRadius();
    super.install();
  }

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

  /// This is a temporary solution to get the screen corner radius of the device.
  /// I am terribly sorry for this :)
  void _setScreenCornerRadius() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final IosDeviceInfo deviceInfo = await deviceInfoPlugin.iosInfo;
    final String deviceName = deviceInfo.utsname.productName;

    const List<String> thitrtyNine = [
      "iPhone X",
      "iPhone Xs",
      "iPhone Xs Max",
      "iPhone 11 Pro",
      "iPhone 11 Pro Max"
    ];
    const List<String> fortyOne = [
      "iPhone Xr",
      "iPhone 11",
    ];
    const List<String> fortyFour = [
      "iPhone 12 mini",
      "iPhone 13 mini",
    ];
    const List<String> fourtySeven = [
      "iPhone 12",
      "iPhone 12 Pro",
      "iPhone 13 Pro",
      "iPhone 14"
    ];
    const List<String> fiftyThree = [
      "iPhone 12 Pro Max",
      "iPhone 13 Pro Max",
      "iPhone 14 Plus"
    ];
    const List<String> fiftyFive = [
      "iPhone 14 Pro",
      "iPhone 14 Pro Max",
      "iPhone 15",
      "iPhone 15 Plus",
      "iPhone 15 Pro",
      "iPhone 15 Pro Max",
    ];

    if (thitrtyNine.contains(deviceName)) {
      screenCornerRadius = 39;
    } else if (fortyOne.contains(deviceName)) {
      screenCornerRadius = 41.5;
    } else if (fortyFour.contains(deviceName)) {
      screenCornerRadius = 44;
    } else if (fourtySeven.contains(deviceName)) {
      screenCornerRadius = 47.33;
    } else if (fiftyThree.contains(deviceName)) {
      screenCornerRadius = 53.33;
    } else if (fiftyFive.contains(deviceName)) {
      screenCornerRadius = 55;
    } else {
      screenCornerRadius = 0;
    }
  }
}
