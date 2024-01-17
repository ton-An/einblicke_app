part of ios_theme;

class IOSColorThemeData {
  const IOSColorThemeData({
    this.primary = IOSColors.primary,
    this.primaryContrast = IOSColors.white,
    this.accent = IOSColors.accent,
    this.translucentBackground = IOSColors.translucentBackground,
    this.cameraViewBackground = IOSColors.cameraViewBackground,
    this.text = IOSColors.black,
    this.buttonLabel = IOSColors.white,
    this.description = IOSColors.description,
    this.activityIndicator = IOSColors.white,
    this.fieldColor = IOSColors.white,
    this.background = IOSColors.lightGray,
    this.error = IOSColors.red,
    this.success = IOSColors.green,
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
}
