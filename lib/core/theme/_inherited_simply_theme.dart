part of ios_theme;

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
