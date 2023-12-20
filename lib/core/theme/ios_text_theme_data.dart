part of ios_theme;

class IOSTextThemeData {
  const IOSTextThemeData({
    TextStyle? navTitle,
    TextStyle? description,
    TextStyle? buttonLabel,
    TextStyle? title,
    TextStyle? smallLabel,
  }) : this._raw(
          const _TextThemeDefaultsBuilder(
            IOSColors.white,
            IOSColors.description,
          ),
          navTitle,
          description,
          buttonLabel,
          title,
          smallLabel,
        );

  const IOSTextThemeData._raw(this._defaults, this._navTitle, this._description,
      this._buttonLabel, this._title, this._smallLabel);

  final _TextThemeDefaultsBuilder _defaults;
  final TextStyle? _navTitle;
  final TextStyle? _description;
  final TextStyle? _buttonLabel;
  final TextStyle? _title;
  final TextStyle? _smallLabel;

  TextStyle get navTitle => _navTitle ?? _defaults.navTitle;

  TextStyle get description => _description ?? _defaults.description;

  TextStyle get buttonLabel => _buttonLabel ?? _defaults.buttonLabel;

  TextStyle get title => _title ?? _defaults.title;

  TextStyle get smallLabel => _smallLabel ?? _defaults.smallLabel;

  /// Returns a copy of the current [IOSTextThemeData] with all the colors
  /// resolved against the given [BuildContext].
  IOSTextThemeData resolveFrom(BuildContext context) {
    return IOSTextThemeData._raw(
      _defaults.resolveFrom(context),
      _resolveTextStyle(_navTitle, context),
      _resolveTextStyle(_description, context),
      _resolveTextStyle(_buttonLabel, context),
      _resolveTextStyle(_title, context),
      _resolveTextStyle(_smallLabel, context),
    );
  }

  TextStyle? _resolveTextStyle(TextStyle? style, BuildContext context) {
    return style?.copyWith(
      color: style.color ?? IOSTheme.of(context).colors.text,
    );
  }
}
