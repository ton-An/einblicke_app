import 'package:einblicke_app/core/dependency_injector.dart';
import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/authentication_status_cubit/authentication_status_cubit.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:einblicke_app/features/authentication/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:einblicke_app/features/authentication/presentation/pages/splash_screen.dart';
import 'package:einblicke_app/features/authentication/presentation/pages/welcome_modal/welcome_modal.dart';
import 'package:einblicke_app/features/in_app_notification/presentation/cubit/in_app_notification_cubit.dart';
import 'package:einblicke_app/features/in_app_notification/presentation/widgets/in_app_notification_listener.dart';
import 'package:einblicke_app/features/select_frame/presentation/pages/select_frame_page/select_frame_page.dart';
import 'package:einblicke_app/features/select_image/presentation/cubits/select_image_cubit.dart';
import 'package:einblicke_app/features/select_image/presentation/pages/select_image_modal/select_image_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as l10n;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:sheet/route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initGetIt();

  runApp(EinblickeApp());
}

class EinblickeApp extends StatelessWidget {
  EinblickeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<InAppNotificationCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthenticationStatusCubit>(),
        ),
      ],
      child: CupertinoApp.router(
        title: "Einblicke",
        localizationsDelegates: const [
          l10n.AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en"),
        ],
        theme: const CupertinoThemeData(
          scaffoldBackgroundColor: IOSColors.white,
        ),
        routerConfig: _router,
      ),
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: SplashScreen.route,
    routes: <RouteBase>[
      ShellRoute(
        builder: (context, state, child) =>
            InAppNotificationListener(child: child),
        routes: [
          GoRoute(
            path: SplashScreen.route,
            pageBuilder: (context, state) => const CupertinoExtendedPage(
              child: SplashScreen(),
            ),
          ),
          GoRoute(
            path: SelectFramePage.route,
            pageBuilder: (context, state) =>
                const CupertinoExtendedPage(child: SelectFramePage()),
            routes: [
              GoRoute(
                path: SelectImageModal.pageName,
                pageBuilder: (context, state) => CupertinoSheetPage(
                  child: BlocProvider(
                    create: (context) => getIt<SelectImageCubit>(),
                    child: const SelectImageModal(),
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: SignInPage.route,
            pageBuilder: (context, state) => CupertinoExtendedPage(
              child: BlocProvider(
                create: (context) => getIt<SignInCubit>(),
                child: const SignInPage(),
              ),
            ),
            routes: <RouteBase>[
              GoRoute(
                path: WelcomeModal.pageName,
                pageBuilder: (context, state) => const CupertinoSheetPage(
                  child: WelcomeModal(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
