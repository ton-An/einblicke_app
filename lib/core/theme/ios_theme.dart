library ios_theme;

import 'package:flutter/cupertino.dart';

part '_default_text_styles.dart';
part '_inherited_simply_theme.dart';
part '_text_theme_defaults_builder.dart';
part 'ios_color_theme_data.dart';
part 'ios_colors.dart';
part 'ios_text_theme_data.dart';
part 'ios_theme_data.dart';

class IOSTheme extends StatelessWidget {
  const IOSTheme({
    super.key,
    required this.data,
    required this.child,
  });

  final SimplyThemeData data;
  final Widget child;

  static SimplyThemeData of(BuildContext context) {
    final _InheritedIOSTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedIOSTheme>();
    return inheritedTheme?.theme.data ?? const SimplyThemeData.IOSThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedIOSTheme(
      theme: this,
      child: child,
    );
  }
}
