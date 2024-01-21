part of sign_in_page;

class _Cover extends StatelessWidget {
  const _Cover({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/unlicensed/cover3.png",
      width: 240,
      height: 240,
      fit: BoxFit.contain,
    );
  }
}
