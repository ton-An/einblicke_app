library login_page;

import 'package:dispatch_pi_app/core/dispatch_properties.dart';
import 'package:dispatch_pi_app/core/l10n/app_localizations.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_button.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_text_button.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_text_field.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/medium_gap.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_states.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/pages/welcome_modal/welcome_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_login_button.dart';
part '_password_field.dart';
part '_title.dart';
part '_username_field.dart';

/// __Login Page__
///
/// ...
///
/// Main contents:
/// - [_Title]
/// - [_PasswordField]
/// - [_PasswordField]
/// - [_SignInButton]
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showWelcomeModal());
  }

  void _showWelcomeModal() {
    showCupertinoModalPopup(
        context: context, builder: ((context) => const WelcomeModal()));
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
      child: Transform.translate(
        offset: Offset(0, 24),
        child: Transform.scale(
          scale: .92,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(DispatchProperties.borderRadius)),
            child: CupertinoPageScaffold(
              child: SafeArea(
                bottom: false,
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: IOSTheme.of(context).spacing.xMedium,
                      right: IOSTheme.of(context).spacing.xMedium,
                      bottom: IOSTheme.of(context).spacing.xMedium,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              SizedBox(
                                height: IOSTheme.of(context).spacing.xxxLarge,
                              ),
                              const _Title(),
                              SizedBox(
                                height: IOSTheme.of(context).spacing.xxLarge,
                              ),
                              const _UsernameField(),
                              const MediumGap(),
                              const _PasswordField(),
                              SizedBox(
                                height: IOSTheme.of(context).spacing.medium,
                              ),
                            ],
                          ),
                        ),
                        const _SignInButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
