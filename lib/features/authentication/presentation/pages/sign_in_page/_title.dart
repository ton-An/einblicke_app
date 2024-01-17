part of login_page;

/// This is the title of the [LoginPage]
class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        children: [
          TextSpan(text: AppLocalizations.of(context)!.login),
        ],
      ),
    );
  }
}
