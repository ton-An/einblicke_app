part of welcome_modal;

class _Image extends StatelessWidget {
  const _Image({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/Cover2.png",
      width: 240,
      height: 240,
      fit: BoxFit.contain,
    );
  }
}
