part of ios_theme;

/// __IOS Theme Data__
///
/// The theme data of the [IOSTheme].
class IOSThemeData {
  const IOSThemeData({
    this.colors = const IOSColorThemeData(),
    this.text = const IOSTextThemeData(),
    this.spacing = const IOSSpacingThemeData(),
  });

  final IOSColorThemeData colors;
  final IOSTextThemeData text;
  final IOSSpacingThemeData spacing;
}
