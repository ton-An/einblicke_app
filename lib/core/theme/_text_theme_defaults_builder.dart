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

  TextStyle get buttonLabel =>
      _applyLabelColor(_DefaultTextSyles.buttonLabel, IOSColors.primary);

  TextStyle get smallLabel =>
      _applyLabelColor(_DefaultTextSyles.smallLabel, color);

  TextStyle get largeTitle =>
      _applyLabelColor(_DefaultTextSyles.largeTitle, color);

  TextStyle get xLargeTitle =>
      _applyLabelColor(_DefaultTextSyles.xLargeTitle, IOSColors.white);

  TextStyle get body => _applyLabelColor(_DefaultTextSyles.body, color);

  TextStyle get textField =>
      _applyLabelColor(_DefaultTextSyles.textField, color);

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
