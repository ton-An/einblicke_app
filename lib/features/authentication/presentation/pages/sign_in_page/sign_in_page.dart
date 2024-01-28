library sign_in_page;

import 'package:dispatch_pi_app/core/l10n/app_localizations.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/medium_gap.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/x_large_gap.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/x_medium_gap.dart';
import 'package:dispatch_pi_app/core/widgets/ios_button.dart';
import 'package:dispatch_pi_app/core/widgets/ios_text_button.dart';
import 'package:dispatch_pi_app/core/widgets/ios_text_field.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_states.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/pages/welcome_modal/welcome_modal.dart';
import 'package:dispatch_pi_app/features/select_frame/pages/select_frame_page/select_frame_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '_cover_artwork.dart';
part '_password_text_field.dart';
part '_sign_in_button.dart';
part '_title.dart';
part '_username_text_field.dart';

/// Sign In Page__
///
/// ...
///
/// Main contents:
/// - [_CoverArtwork]
/// - [_Title]
/// - [_PasswordTextField]
/// - [_PasswordTextField]
/// - [_SignInButton]
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const String pageName = "sign_in";
  static const String route = "/$pageName";

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showWelcomeModal());
  }

  void _showWelcomeModal() {
    context.go(WelcomeModal.route);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: context.read<SignInCubit>(),
      listener: (context, state) {
        if (state is SignInSuccess) {
          context.push(SelectFramePage.route);
        }
      },
      child: CupertinoPageScaffold(
        child: SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.only(
              left: IOSTheme.of(context).spacing.xMedium,
              right: IOSTheme.of(context).spacing.xMedium,
              bottom: IOSTheme.of(context).spacing.xLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: IOSTheme.of(context).spacing.xLarge + 30,
                      ),

                      // -- Cover Artwork --
                      const _CoverArtwork(),
                      const XLargeGap(),

                      // -- Title --
                      const _Title(),
                      const XMediumGap(),

                      // -- Username Text Field --
                      const _UsernameTextField(),
                      const MediumGap(),

                      // -- Password Text Field --
                      const _PasswordTextField(),
                      const MediumGap(),
                    ],
                  ),
                ),
                const XMediumGap(),
                const _SignInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
