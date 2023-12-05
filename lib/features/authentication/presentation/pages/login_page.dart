import 'package:dispatch_pi_app/core/dispatch_properties.dart';
import 'package:dispatch_pi_app/core/l10n/app_localizations.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_text_button.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DispatchProperties.mediumPadding,
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              DispatchTextButton(
                text: AppLocalizations.of(context)!.login,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
