part of welcome_modal;

class _Description extends StatelessWidget {
  const _Description({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      """
This app brings your health
information together in one place.

You can see important changes or
alerts, get insights from your data
and learn about essential topics.
    """,
      textAlign: TextAlign.center,
      style: TextStyle(
        inherit: false,
        fontFamily: '.SF Pro Text',
        fontSize: 17.0,
        letterSpacing: -0.4,
        height: 1.29,
        color: CupertinoColors.label,
      ),
    );
  }
}
