part of ios_theme;

/// __IOS Theme__
///
/// A wrapper for the [Theme] widget that provides an [IOSThemeData] to its
/// children via [InheritedWidget].
class _InheritedIOSTheme extends InheritedWidget {
  const _InheritedIOSTheme({
    required this.theme,
    required super.child,
  });

  final IOSTheme theme;

  @override
  bool updateShouldNotify(_InheritedIOSTheme old) =>
      theme.data != old.theme.data;
}
