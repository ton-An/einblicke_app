library welcome_modal;

import 'package:dispatch_pi_app/core/dispatch_properties.dart';
import 'package:dispatch_pi_app/core/l10n/app_localizations.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_text_button.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/smaller_gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

part '_continue_button.dart';
part '_feature_tile.dart';
part '_features.dart';
part '_title.dart';

/// __Welcome Modal__
///
/// This modal is shown when the user opens the app for the first time.
/// It contains a short description of the app and its features.
///
/// Main contents:
/// - [_Title]
/// - [_Features]
/// - [_ContinueButton]
class WelcomeModal extends StatelessWidget {
  const WelcomeModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DispatchProperties.borderRadius),
        child: CupertinoPageScaffold(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(
                left: DispatchProperties.largePadding,
                right: DispatchProperties.largePadding,
                bottom: DispatchProperties.largestPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView(
                      children: const [
                        SizedBox(
                          height: DispatchProperties.largerPadding * 2,
                        ),
                        _Title(),
                        SizedBox(
                          height: DispatchProperties.mediumPadding,
                        ),
                        _Features(),
                      ],
                    ),
                  ),
                  const _ContinueButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
