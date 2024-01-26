import 'package:dispatch_pi_app/core/dependency_injector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
          context.go("/select_frame");
        } else {
          context.go("/sign_in");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Container());
  }
}
