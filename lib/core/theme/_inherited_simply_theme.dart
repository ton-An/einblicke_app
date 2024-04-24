part of custom_cupertino_theme;

/// __Custom Cupertino Theme__
///
/// A wrapper for the [Theme] widget that provides an [CustomCupertinoThemeData] to its
/// children via [InheritedWidget].
class _InheritedCustomCupertinoTheme extends InheritedWidget {
  const _InheritedCustomCupertinoTheme({
    required this.theme,
    required super.child,
  });

  final CustomCupertinoTheme theme;

  @override
  bool updateShouldNotify(_InheritedCustomCupertinoTheme old) =>
      theme.data != old.theme.data;
}
