part of ios_theme;

class SimplyThemeData {
  const SimplyThemeData.IOSThemeData({
    this.colors = const IOSColorThemeData(),
    this.text = const IOSTextThemeData(),
  });

  final IOSColorThemeData colors;
  final IOSTextThemeData text;
}
