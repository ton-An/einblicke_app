import 'package:dispatch_pi_app/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const DispatchPiApp());
}

class DispatchPiApp extends StatelessWidget {
  const DispatchPiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: "Dispatch Pi",
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en"),
      ],
      theme: CupertinoThemeData(
        scaffoldBackgroundColor: CupertinoColors.white,
      ),
      home: LoginPage(),
    );
  }
}
