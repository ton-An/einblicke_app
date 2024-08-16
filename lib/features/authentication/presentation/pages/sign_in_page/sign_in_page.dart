library sign_in_page;

import 'package:einblicke_app/core/l10n/app_localizations.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_button.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_text_button.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_text_field.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_states.dart';
import 'package:einblicke_app/features/authentication/presentation/pages/welcome_modal/welcome_modal.dart';
import 'package:einblicke_app/features/select_frame/presentation/pages/select_frame_page/select_frame_page.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '_cover_artwork.dart';
part '_password_text_field.dart';
part '_sign_in_button.dart';
part '_title.dart';
part '_username_text_field.dart';

/// __Sign In Page__
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
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => context.go(WelcomeModal.route));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: context.read<SignInCubit>(),
      listener: (context, state) {
        if (state is SignInSuccess) {
          context.push(SelectFramePage.route);
        } else if (state is SignInFailure) {
          context
              .read<InAppNotificationCubit>()
              .sendFailureNotification(state.failure);
        }
      },
      child: CupertinoPageScaffold(
        child: SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.only(
              left: CustomCupertinoTheme.of(context).spacing.xMedium,
              right: CustomCupertinoTheme.of(context).spacing.xMedium,
              bottom: CustomCupertinoTheme.of(context).spacing.xLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        height:
                            CustomCupertinoTheme.of(context).spacing.xLarge +
                                30,
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
