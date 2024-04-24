part of custom_cupertino_theme;

/*
  To-Dos:
  - [ ] Organize colors
*/

/// __Custom Cupertino Color Theme Data__
///
/// A collection of Cupertino colors for the [CustomCupertinoTheme].
class CustomCupertinoColorThemeData {
  const CustomCupertinoColorThemeData({
    this.primary = CustomCupertinoColors.primary,
    this.primaryContrast = CustomCupertinoColors.white,
    this.accent = CustomCupertinoColors.accent,
    this.translucentBackground = CustomCupertinoColors.translucentBackground,
    this.cameraViewBackground = CustomCupertinoColors.cameraViewBackground,
    this.text = CustomCupertinoColors.black,
    this.buttonLabel = CustomCupertinoColors.white,
    this.description = CustomCupertinoColors.description,
    this.activityIndicator = CustomCupertinoColors.white,
    this.fieldColor = CustomCupertinoColors.lightGray,
    this.background = CustomCupertinoColors.white,
    this.error = CustomCupertinoColors.red,
    this.success = CustomCupertinoColors.green,
    this.border = CustomCupertinoColors.border,
    this.hint = CustomCupertinoColors.hint,
    this.disabledButton = CustomCupertinoColors.disabled,
    this.transparent = CustomCupertinoColors.transparent,
    this.backgroundContrast = CustomCupertinoColors.black,
  });

  final Color primary;
  final Color primaryContrast;
  final Color accent;
  final Color translucentBackground;
  final Color cameraViewBackground;
  final Color text;
  final Color buttonLabel;
  final Color description;
  final Color activityIndicator;
  final Color fieldColor;
  final Color background;
  final Color error;
  final Color success;
  final Color border;
  final Color hint;
  final Color disabledButton;
  final Color transparent;
  final Color backgroundContrast;
}
