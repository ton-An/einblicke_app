part of sign_in_page;

/// This is the title of the [SignInPage]
class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: CustomCupertinoTheme.of(context).text.largeTitle,
        children: [
          TextSpan(text: AppLocalizations.of(context)!.login),
        ],
      ),
    );
  }
}
