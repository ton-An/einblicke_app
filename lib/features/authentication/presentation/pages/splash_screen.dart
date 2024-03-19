import 'package:einblicke_app/features/authentication/presentation/cubits/authentication_status_cubit/authentication_states.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/authentication_status_cubit/authentication_status_cubit.dart';
import 'package:einblicke_app/features/select_frame/pages/select_frame_page/select_frame_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/*
  To-Dos:
  - [ ] Remove ability to go back to this screen
*/

/// __Splash Screen__
///
/// The splash screen of the app.
/// Checks if the user is signed in and redirects to the appropriate page.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String pageName = "splash_screen";
  static const String route = "/$pageName";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationStatusCubit>().ceckAuthenticationStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationStatusCubit, AuthenticationState>(
      bloc: context.read<AuthenticationStatusCubit>(),
      listener: (context, state) {
        // if (state is AuthenticationSignedIn) {
        context.go(SelectFramePage.route);
        // } else if (state is AuthenticationSignedOut) {
        //   context.go(SignInPage.route);
        // } else if (state is AuthenticationFailureState) {
        //   context
        //       .read<InAppNotificationCubit>()
        //       .sendFailureNotification(state.failure);
        //   context.go(SignInPage.route);
        // }
      },
      child: const CupertinoPageScaffold(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
