part of welcome_modal;

/// This is the description of the [WelcomeModal]
class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.welcomeDescription,
      textAlign: TextAlign.center,
      style: CustomCupertinoTheme.of(context).text.body,
    );
  }
}
