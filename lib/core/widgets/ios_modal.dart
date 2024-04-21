library welcome_modal;

import 'package:einblicke_app/core/ios_properties.dart';
import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/*
  To-Dos:
  - [ ] Add option for ability to disable/enable dismiss by scrolling or tapping outside of the modal
  - [ ] Add option for cancel button at the top
  - [ ] Look at why two SafeAreas are needed
*/

/// __IOS Modal__
///
/// A modal that is styled like an iOS modal.
class IOSModal extends StatelessWidget {
  const IOSModal({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(IOSProperties.borderRadius - 3),
          child: CupertinoPageScaffold(
            child: SafeArea(
              top: false,
              right: false,
              left: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: IOSTheme.of(context).spacing.xSmall,
                          bottom: IOSTheme.of(context).spacing.xxMedium,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "Cancel",
                                style: IOSTheme.of(context).text.body.copyWith(
                                    color: IOSTheme.of(context).colors.primary),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Select an Image",
                                textAlign: TextAlign.center,
                                style: IOSTheme.of(context)
                                    .text
                                    .buttonLabel
                                    .copyWith(
                                      color: IOSTheme.of(context).colors.text,
                                    ),
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: IOSTheme.of(context).spacing.xMedium,
                        right: IOSTheme.of(context).spacing.xMedium,
                        bottom: IOSTheme.of(context).spacing.xLarge,
                      ),
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
