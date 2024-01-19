part of welcome_modal;

/// This is the title of the [WelcomeModal]
class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      "${AppLocalizations.of(context)!.welcomeTo}\n${AppLocalizations.of(context)!.shortAppName}",
      textAlign: TextAlign.center,
      style: IOSTheme.of(context).text.largeTitle,
    );
  }
}
