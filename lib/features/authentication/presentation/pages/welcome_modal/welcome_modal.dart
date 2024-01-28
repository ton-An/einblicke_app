library welcome_modal;

import 'package:dispatch_pi_app/core/ios_properties.dart';
import 'package:dispatch_pi_app/core/l10n/app_localizations.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/x_large_gap.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/x_medium_gap.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/xx_medium_gap.dart';
import 'package:dispatch_pi_app/core/widgets/ios_text_button.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

part '_continue_button.dart';
part '_cover_artwork.dart';
part '_description.dart';
part '_title.dart';
part '_wrapper.dart';

/// __Welcome Modal__
///
/// This modal is shown when the user opens the app for the first time.
/// It contains a short description of the app and its features and a button
/// to request permissions and to continue to the sign in page.
///
/// Main contents:
/// - [_CoverArtwork]
/// - [_Title]
/// - [_Description]
/// - [_ContinueButton]
class WelcomeModal extends StatelessWidget {
  const WelcomeModal({super.key});

  static const String pageName = "welcome_modal";
  static const String route = "${SignInPage.route}/$pageName";

  @override
  Widget build(BuildContext context) {
    return _Wrapper(
      children: [
        Expanded(
          child: ListView(
            children: [
              const XLargeGap(),

              // -- Cover Artwork --
              const _CoverArtwork(),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: IOSTheme.of(context).spacing.xMedium,
                ),
                child: const Column(
                  children: [
                    XXMediumGap(),

                    // -- Title --
                    _Title(),
                    XMediumGap(),

                    // -- Description --
                    _Description(),
                    XLargeGap(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const XMediumGap(),

        // -- Continue button --
        const _ContinueButton(),
      ],
    );
  }
}
