part of custom_cupertino_theme;

/// __Custom Cupertino Theme Data__
///
/// The theme data of the [CustomCupertinoTheme].
class CustomCupertinoThemeData {
  const CustomCupertinoThemeData({
    this.colors = const CustomCupertinoColorThemeData(),
    this.text = const CustomCupertinoTextThemeData(),
    this.spacing = const CustomCupertinoSpacingThemeData(),
  });

  final CustomCupertinoColorThemeData colors;
  final CustomCupertinoTextThemeData text;
  final CustomCupertinoSpacingThemeData spacing;
}
