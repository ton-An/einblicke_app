part of ios_theme;

class IOSSpacingThemeData {
  const IOSSpacingThemeData({
    double? tiny,
    double? xTiny,
    double? small,
    double? xSmall,
    double? xxSmall,
    double? medium,
    double? xMedium,
    double? xxMedium,
    double? large,
    double? xxLarge,
    double? xxxLarge,
  }) : this._(
          tiny,
          xTiny,
          small,
          xSmall,
          xxSmall,
          medium,
          xMedium,
          xxMedium,
          large,
          xxLarge,
          xxxLarge,
        );

  const IOSSpacingThemeData._(
    this._tiny,
    this._xTiny,
    this._small,
    this._xSmall,
    this._xxSmall,
    this._medium,
    this._xMedium,
    this._xxMedium,
    this._large,
    this._xxLarge,
    this._xxxLarge,
  );

  final double? _tiny;
  final double? _xTiny;
  final double? _small;
  final double? _xSmall;
  final double? _xxSmall;
  final double? _medium;
  final double? _xMedium;
  final double? _xxMedium;
  final double? _large;
  final double? _xxLarge;
  final double? _xxxLarge;

  double get tiny => _tiny ?? _DefaultSpacing.tiny;
  double get xTiny => _xTiny ?? _DefaultSpacing.xTiny;
  double get small => _small ?? _DefaultSpacing.small;
  double get xSmall => _xSmall ?? _DefaultSpacing.xSmall;
  double get xxSmall => _xxSmall ?? _DefaultSpacing.xxSmall;
  double get medium => _medium ?? _DefaultSpacing.medium;
  double get xMedium => _xMedium ?? _DefaultSpacing.xMedium;
  double get xxMedium => _xxMedium ?? _DefaultSpacing.xxMedium;
  double get large => _large ?? _DefaultSpacing.large;
  double get xxLarge => _xxLarge ?? _DefaultSpacing.xxLarge;
  double get xxxLarge => _xxxLarge ?? _DefaultSpacing.xxxLarge;
}
