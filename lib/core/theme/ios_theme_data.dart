part of ios_theme;

class IOSThemeData {
  const IOSThemeData.IOSThemeData({
    this.colors = const IOSColorThemeData(),
    this.text = const IOSTextThemeData(),
  });

  final IOSColorThemeData colors;
  final IOSTextThemeData text;
}
