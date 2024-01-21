part of welcome_modal;

class _Description extends StatelessWidget {
  const _Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      """
This app lets you send your favourite moments right to your loved ones picture frames.

You can send photos along with personal messages to your friends and family. The only thing they need is a disptach frame.
    """,
      textAlign: TextAlign.center,
      style: IOSTheme.of(context).text.body,
    );
  }
}
