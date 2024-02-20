import 'package:einblicke_app/core/dependency_injector.dart';
import 'package:einblicke_app/features/authentication/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:einblicke_app/features/select_image/pages/select_image_modal/select_image_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  static const String pageName = "/";
  static const String route = pageName;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkSignInStatus());
  }

  void _checkSignInStatus() async {
    getIt<FlutterSecureStorage>().containsKey(key: "access_token").then(
      (bool isSignedIn) {
        if (isSignedIn) {
          context.go(SelectImageModal.route);
          // context.go(SelectFramePage.route);
        } else {
          context.go(SignInPage.route);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
