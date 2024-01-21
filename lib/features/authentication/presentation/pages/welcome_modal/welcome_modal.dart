library welcome_modal;

import 'package:dispatch_pi_app/core/dispatch_properties.dart';
import 'package:dispatch_pi_app/core/l10n/app_localizations.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_text_button.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/x_medium_gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

part '_continue_button.dart';
part '_cover.dart';
part '_description.dart';
part '_title.dart';

/// __Welcome Modal__
///
/// This modal is shown when the user opens the app for the first time.
/// It contains a short description of the app and its features.
///
/// Main contents:
/// - [_Cover]
/// - [_Title]
/// - [_Description]
/// - [_ContinueButton]
class WelcomeModal extends StatelessWidget {
  const WelcomeModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(
          top: IOSTheme.of(context).spacing.xSmall,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(DispatchProperties.borderRadius),
          child: CupertinoPageScaffold(
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                  left: IOSTheme.of(context).spacing.xMedium,
                  right: IOSTheme.of(context).spacing.xMedium,
                  bottom: IOSTheme.of(context).spacing.xxLarge,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView(
                        // reverse: true,
                        children: [
                          SizedBox(
                            height: IOSTheme.of(context).spacing.xxLarge,
                          ),
                          const _Cover(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    IOSTheme.of(context).spacing.xMedium),
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      IOSTheme.of(context).spacing.xxLarge - 20,
                                ),
                                const _Title(),
                                SizedBox(
                                  height: IOSTheme.of(context).spacing.xMedium,
                                ),
                                const _Description(),
                                SizedBox(
                                  height: IOSTheme.of(context).spacing.large,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const XMediumGap(),
                    const _ContinueButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
