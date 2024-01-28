import 'package:dispatch_pi_app/core/dependency_injector.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:dispatch_pi_app/features/select_frame/pages/select_frame_page/select_frame_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

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
          context.go(SelectFramePage.route);
        } else {
          context.go(SignInPage.route);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Container());
  }
}
