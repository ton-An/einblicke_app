part of ios_theme;

@immutable
class _TextThemeDefaultsBuilder {
  const _TextThemeDefaultsBuilder(
    this.color,
    this.descriptionColor,
  );

  final Color color;
  final Color descriptionColor;

  static TextStyle _applyLabelColor(TextStyle original, Color color) {
    return original.color == color ? original : original.copyWith(color: color);
  }

  TextStyle get navTitle => _applyLabelColor(_kNavDefaultTitleTextStyle, color);

  TextStyle get description =>
      _applyLabelColor(_kDescriptionTextStyle, descriptionColor);

  TextStyle get buttonLabel =>
      _applyLabelColor(_kDefaultButtonLabelTextStyle, IOSColors.primary);

  TextStyle get title => _applyLabelColor(_kTitleTextStyle, color);

  TextStyle get smallLabel => _applyLabelColor(_kSmallLabelTextStyle, color);

  TextStyle get largeTitle => _applyLabelColor(_kLargeTitle, color);

  TextStyle get body => _applyLabelColor(_kBody, color);

  _TextThemeDefaultsBuilder resolveFrom(BuildContext context) {
    final Color resolvedColor = IOSTheme.of(context).colors.text;
    final Color resolvedDescriptionColor =
        IOSTheme.of(context).colors.description;

    return resolvedColor == color &&
            resolvedDescriptionColor == descriptionColor
        ? this
        : _TextThemeDefaultsBuilder(resolvedColor, resolvedDescriptionColor);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _TextThemeDefaultsBuilder &&
        other.color == color &&
        other.descriptionColor == descriptionColor;
  }

  @override
  int get hashCode => Object.hash(color, descriptionColor);
}
