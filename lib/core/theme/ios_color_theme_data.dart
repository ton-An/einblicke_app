part of ios_theme;

class IOSColorThemeData {
  const IOSColorThemeData({
    this.primary = IOSColors.primary,
    this.primaryContrast = IOSColors.white,
    this.accent = IOSColors.accent,
    this.translucentBackground = IOSColors.translucentBackground,
    this.cameraViewBackground = IOSColors.cameraViewBackground,
    this.text = IOSColors.black,
    this.description = IOSColors.description,
    this.activityIndicator = IOSColors.white,
  });

  final Color primary;
  final Color primaryContrast;
  final Color accent;
  final Color translucentBackground;
  final Color cameraViewBackground;
  final Color text;
  final Color description;
  final Color activityIndicator;
}
