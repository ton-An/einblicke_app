part of ios_theme;

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
