part of welcome_modal;

/// This is the title of the [WelcomeModal]
class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      "${AppLocalizations.of(context)!.welcomeTo} ${AppLocalizations.of(context)!.appName}",
      textAlign: TextAlign.center,
      style: IOSTheme.of(context).text.largeTitle,
    );
  }
}
