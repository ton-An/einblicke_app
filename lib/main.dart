import 'package:einblicke_app/core/dependency_injector.dart';
import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:einblicke_app/features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:einblicke_app/features/authentication/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:einblicke_app/features/authentication/presentation/pages/splash_screen.dart';
import 'package:einblicke_app/features/authentication/presentation/pages/welcome_modal/welcome_modal.dart';
import 'package:einblicke_app/features/select_image/cubits/select_image_cubit.dart';
import 'package:einblicke_app/features/select_image/pages/select_image_modal/select_image_modal.dart';
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
    return CupertinoApp.router(
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
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: SplashScreen.route,
    routes: <RouteBase>[
      GoRoute(
        path: SplashScreen.pageName,
        pageBuilder: (context, state) =>
            const CupertinoExtendedPage(child: SplashScreen()),
        routes: [
          GoRoute(
            path: SelectImageModal.pageName,
            pageBuilder: (context, state) => CupertinoExtendedPage(
              child: BlocProvider(
                create: (context) => getIt<SelectImageCubit>(),
                child: const SelectImageModal(),
              ),
            ),
          ),
          // GoRoute(
          //   path: SelectFramePage.pageName,
          //   pageBuilder: (context, state) =>
          //       const CupertinoExtendedPage(child: SelectFramePage()),
          //   routes: [
          //     GoRoute(
          //       path: SelectImageModal.pageName,
          //       pageBuilder: (context, state) => CupertinoSheetPage(
          //         child: BlocProvider(
          //           create: (context) => getIt<SelectImageCubit>(),
          //           child: const SelectImageModal(),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          GoRoute(
            path: SignInPage.pageName,
            pageBuilder: (context, state) => CupertinoExtendedPage(
              child: BlocProvider(
                create: (context) => getIt<SignInCubit>(),
                child: const SignInPage(),
              ),
            ),
            routes: <RouteBase>[
              GoRoute(
                path: WelcomeModal.pageName,
                pageBuilder: (context, state) => CupertinoSheetPage(
                  child: BlocProvider(
                    create: (context) => getIt<SignInCubit>(),
                    child: const WelcomeModal(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
