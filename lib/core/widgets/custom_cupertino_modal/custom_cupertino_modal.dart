library welcome_modal;

import 'package:einblicke_app/core/widgets/custom_cupertino_modal/custom_cupertino_top_bar.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';
import 'package:flutter/cupertino.dart';

/// __Custom Cupertino Modal__
///
/// A modal that is styled like a Cupertino modal with an optional top bar.
class CustomCupertinoModal extends StatelessWidget {
  const CustomCupertinoModal({
    super.key,
    required this.child,
    this.topBar,
  });

  final CustomCupertinoModalTopBar? topBar;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(CustomCupertinoProperties.smallBorderRadius),
      child: ColoredBox(
        color: CustomCupertinoTheme.of(context).colors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (topBar != null) topBar!,
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: CustomCupertinoTheme.of(context).spacing.xMedium,
                  right: CustomCupertinoTheme.of(context).spacing.xMedium,
                  bottom: CustomCupertinoTheme.of(context).spacing.xLarge +
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
