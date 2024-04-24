part of custom_cupertino_theme;

/// __Custom Cupertino Text Theme Data__
///
/// A collection of Cupertino text styles for the [CustomCupertinoTheme].
class CustomCupertinoTextThemeData {
  const CustomCupertinoTextThemeData({
    TextStyle? buttonLabel,
    TextStyle? title,
    TextStyle? smallLabel,
    TextStyle? largeTitle,
    TextStyle? xLargeTitle,
    TextStyle? body,
    TextStyle? textField,
  }) : this._raw(
          const _TextThemeDefaultsBuilder(
            CustomCupertinoColors.black,
            CustomCupertinoColors.description,
          ),
          buttonLabel,
          smallLabel,
          largeTitle,
          xLargeTitle,
          body,
          textField,
        );

  const CustomCupertinoTextThemeData._raw(
    this._defaults,
    this._buttonLabel,
    this._smallLabel,
    this._largeTitle,
    this._xLargeTitle,
    this._body,
    this._textField,
  );

  final _TextThemeDefaultsBuilder _defaults;
  final TextStyle? _buttonLabel;
  final TextStyle? _smallLabel;
  final TextStyle? _largeTitle;
  final TextStyle? _xLargeTitle;
  final TextStyle? _body;
  final TextStyle? _textField;

  TextStyle get buttonLabel => _buttonLabel ?? _defaults.buttonLabel;

  TextStyle get smallLabel => _smallLabel ?? _defaults.smallLabel;

  TextStyle get largeTitle => _largeTitle ?? _defaults.largeTitle;

  TextStyle get xLargeTitle => _xLargeTitle ?? _defaults.xLargeTitle;

  TextStyle get body => _body ?? _defaults.body;

  TextStyle get textField => _textField ?? _defaults.textField;

  /// Returns a copy of the current [CustomCupertinoTextThemeData] with all the colors
  /// resolved against the given [BuildContext].
  CustomCupertinoTextThemeData resolveFrom(BuildContext context) {
    return CustomCupertinoTextThemeData._raw(
      _defaults.resolveFrom(context),
      _resolveTextStyle(_buttonLabel, context),
      _resolveTextStyle(_smallLabel, context),
      _resolveTextStyle(_largeTitle, context),
      _resolveTextStyle(_xLargeTitle, context),
      _resolveTextStyle(_body, context),
      _resolveTextStyle(_textField, context),
    );
  }

  TextStyle? _resolveTextStyle(TextStyle? style, BuildContext context) {
    return style?.copyWith(
      color: style.color ?? CustomCupertinoTheme.of(context).colors.text,
    );
  }
}
