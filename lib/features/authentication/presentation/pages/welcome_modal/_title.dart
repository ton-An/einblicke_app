part of welcome_modal;

/// This is the title of the [WelcomeModal]
class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        children: [
          TextSpan(text: "${AppLocalizations.of(context)!.welcomeTo}\n"),
          TextSpan(text: AppLocalizations.of(context)!.appName),
        ],
      ),
    );
  }
}
