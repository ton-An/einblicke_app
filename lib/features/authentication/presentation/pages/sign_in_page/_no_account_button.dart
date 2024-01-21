part of sign_in_page;

class _NoAccountButton extends StatelessWidget {
  const _NoAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "No Account?",
      style: IOSTheme.of(context).text.smallLabel,
    );
  }
}
