import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as l10n;

abstract class AppLocalizations extends l10n.AppLocalizations {
  AppLocalizations(super.locale);
  static l10n.AppLocalizations? of(BuildContext context) {
    return Localizations.of<l10n.AppLocalizations>(
      context,
      l10n.AppLocalizations,
    );
  }
}
