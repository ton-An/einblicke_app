library welcome_modal;

import 'package:einblicke_app/core/ios_properties.dart';
import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:einblicke_app/core/widgets/ios_modal/ios_modal_top_bar.dart';
import 'package:flutter/cupertino.dart';

/// __IOS Modal__
///
/// A modal that is styled like an IOS modal with an optional top bar.
class IOSModal extends StatelessWidget {
  const IOSModal({
    super.key,
    required this.child,
    this.topBar,
  });

  final IOSModalTopBar? topBar;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(IOSProperties.smallBorderRadius),
      child: ColoredBox(
        color: IOSTheme.of(context).colors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (topBar != null) topBar!,
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: IOSTheme.of(context).spacing.xMedium,
                  right: IOSTheme.of(context).spacing.xMedium,
                  bottom: IOSTheme.of(context).spacing.xLarge +
                      MediaQuery.of(context).padding.bottom,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
