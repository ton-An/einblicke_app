import 'package:dispatch_pi_app/core/dependency_injector.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/pages/splash_screen.dart';
import 'package:dispatch_pi_app/features/select_image/cubits/select_image_cubit.dart';
import 'package:dispatch_pi_app/features/select_image/pages/select_image_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initGetIt();

  runApp(const DispatchPiApp());
}

class DispatchPiApp extends StatelessWidget {
  const DispatchPiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "Dispatch Pi",
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
      ],
      theme: const CupertinoThemeData(
        scaffoldBackgroundColor: IOSColors.lightGray,
      ),
      onGenerateRoute: (settings) => onGenerateRoute(settings),
    );
  }

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/select_image":
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SelectImageCubit>(),
            child: const SelectImage(),
          ),
        );
      case "/sign_in":
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignInCubit>(),
            child: const LoginPage(),
          ),
        );
      default:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );
    }
  }
}
