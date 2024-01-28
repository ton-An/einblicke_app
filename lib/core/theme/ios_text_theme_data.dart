part of ios_theme;

/// __IOS Text Theme Data__
///
/// A collection of iOS text styles for the [IOSTheme].
class IOSTextThemeData {
  const IOSTextThemeData({
    TextStyle? buttonLabel,
    TextStyle? title,
    TextStyle? smallLabel,
    TextStyle? largeTitle,
    TextStyle? body,
    TextStyle? textField,
  }) : this._raw(
          const _TextThemeDefaultsBuilder(
            IOSColors.black,
            IOSColors.description,
          ),
          buttonLabel,
          smallLabel,
          largeTitle,
          body,
          textField,
        );

  const IOSTextThemeData._raw(
    this._defaults,
    this._buttonLabel,
    this._smallLabel,
    this._largeTitle,
    this._body,
    this._textField,
  );

  final _TextThemeDefaultsBuilder _defaults;
  final TextStyle? _buttonLabel;
  final TextStyle? _smallLabel;
  final TextStyle? _largeTitle;
  final TextStyle? _body;
  final TextStyle? _textField;

  TextStyle get buttonLabel => _buttonLabel ?? _defaults.buttonLabel;

  TextStyle get smallLabel => _smallLabel ?? _defaults.smallLabel;

  TextStyle get largeTitle => _largeTitle ?? _defaults.largeTitle;

  TextStyle get body => _body ?? _defaults.body;

  TextStyle get textField => _textField ?? _defaults.textField;

  /// Returns a copy of the current [IOSTextThemeData] with all the colors
  /// resolved against the given [BuildContext].
  IOSTextThemeData resolveFrom(BuildContext context) {
    return IOSTextThemeData._raw(
      _defaults.resolveFrom(context),
      _resolveTextStyle(_buttonLabel, context),
      _resolveTextStyle(_smallLabel, context),
      _resolveTextStyle(_largeTitle, context),
      _resolveTextStyle(_body, context),
      _resolveTextStyle(_textField, context),
    );
  }

  TextStyle? _resolveTextStyle(TextStyle? style, BuildContext context) {
    return style?.copyWith(
      color: style.color ?? IOSTheme.of(context).colors.text,
    );
  }
}
