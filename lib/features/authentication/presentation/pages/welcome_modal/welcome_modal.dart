library welcome_modal;

import 'package:einblicke_app/core/l10n/app_localizations.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_modal/custom_cupertino_modal.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_text_button.dart';
import 'package:einblicke_app/features/authentication/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

part '_continue_button.dart';
part '_cover_artwork.dart';
part '_description.dart';
part '_title.dart';

/*
  To-Dos:
  - [ ] Remove ability to dismiss by scrolling or tapping outside of the modal
*/

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
    return CustomCupertinoModal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                // -- Cover Artwork --
                const _CoverArtwork(),
                const XXMediumGap(),
                const _Title(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        CustomCupertinoTheme.of(context).spacing.xMedium,
                  ),
                  child: const Column(
                    children: [
                      // -- Title --
                      MediumGap(),

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
      ),
    );
  }
}
