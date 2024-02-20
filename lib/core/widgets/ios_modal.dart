library welcome_modal;

import 'package:einblicke_app/core/ios_properties.dart';
import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:flutter/cupertino.dart';

/*
  To-Dos:
  - [ ] Add option for ability to disable/enable dismiss by scrolling or tapping outside of the modal
  - [ ] Add option for cancel button at the top
*/

/// __IOS Modal__
///
/// A modal that is styled like an iOS modal.
class IOSModal extends StatelessWidget {
  const IOSModal({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(
          top: IOSTheme.of(context).spacing.xSmall,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(IOSProperties.borderRadius),
          child: CupertinoPageScaffold(
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                  left: IOSTheme.of(context).spacing.xMedium,
                  right: IOSTheme.of(context).spacing.xMedium,
                  bottom: IOSTheme.of(context).spacing.xLarge,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
