library sign_in_page;

import 'package:dispatch_pi_app/core/l10n/app_localizations.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_button.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_text_button.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_text_field.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/medium_gap.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/x_large_gap.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/x_medium_gap.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '_cover.dart';
part '_login_button.dart';
part '_no_account_button.dart';
part '_password_field.dart';
part '_title.dart';
part '_username_field.dart';

/// Sign In Page__
///
/// ...
///
/// Main contents:
/// - [_Cover]
/// - [_Title]
/// - [_PasswordField]
/// - [_PasswordField]
/// - [_SignInButton]
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showWelcomeModal());
  }

  void _showWelcomeModal() {
    context.go("/sign_in/welcome_modal");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: context.read<SignInCubit>(),
      listener: (context, state) {
        if (state is SignInSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/select_image",
            (route) => false,
          );
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
                      const _Cover(),
                      const XLargeGap(),
                      const _Title(),
                      const XMediumGap(),
                      const _UsernameField(),
                      const MediumGap(),
                      const _PasswordField(),
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
