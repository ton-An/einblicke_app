part of ios_theme;

/// __Default Text Syles__
///
/// The default text styles for the [IOSTheme].
class _DefaultTextSyles {
  static const TextStyle buttonLabel = TextStyle(
    inherit: false,
    fontFamily: '.SF Pro Text',
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.41,
    color: CupertinoColors.label,
  );

  static const TextStyle textField = TextStyle(
      inherit: false,
      fontFamily: '.SF Pro Display',
      fontSize: 17.0,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.41,
      color: CupertinoColors.label);

  static const TextStyle smallLabel = TextStyle(
    inherit: false,
    fontFamily: '.SF Pro Display',
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.24,
    color: CupertinoColors.white,
  );

  static const TextStyle largeTitle = TextStyle(
    inherit: false,
    fontFamily: '.SF Pro Display',
    fontSize: 34.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.25,
    wordSpacing: -1.1,
    height: 1.2,
    color: CupertinoColors.label,
  );

  static const TextStyle xLargeTitle = TextStyle(
    inherit: false,
    fontFamily: '.SF Pro Display',
    fontSize: 56.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.25,
    wordSpacing: -1.1,
    height: 1.2,
    color: CupertinoColors.white,
  );

  static const TextStyle body = TextStyle(
    inherit: false,
    fontFamily: '.SF Pro Text',
    fontSize: 17.0,
    letterSpacing: -0.4,
    height: 1.29,
    color: CupertinoColors.label,
  );
}
