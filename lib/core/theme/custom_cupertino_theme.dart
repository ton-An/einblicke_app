library custom_cupertino_theme;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part '_default_spacing.dart';
part '_default_text_styles.dart';
part '_inherited_simply_theme.dart';
part '_text_theme_defaults_builder.dart';
part 'custom_cupertino_color_theme_data.dart';
part 'custom_cupertino_colors.dart';
part 'custom_cupertino_spacing_theme_data.dart';
part 'custom_cupertino_text_theme_data.dart';
part 'custom_cupertino_theme_data.dart';

class CustomCupertinoTheme extends StatelessWidget {
  const CustomCupertinoTheme({
    super.key,
    required this.data,
    required this.child,
  });

  final CustomCupertinoThemeData data;
  final Widget child;

  static CustomCupertinoThemeData of(BuildContext context) {
    final _InheritedCustomCupertinoTheme? inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedCustomCupertinoTheme>();
    return inheritedTheme?.theme.data ?? const CustomCupertinoThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedCustomCupertinoTheme(
      theme: this,
      child: child,
    );
  }
}
