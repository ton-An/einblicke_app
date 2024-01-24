part of sign_in_page;

class _NoAccountButton extends StatelessWidget {
  const _NoAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "",
      style: TextStyle(
          inherit: false,
          fontFamily: '.SF Pro Display',
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          letterSpacing: .1,
          wordSpacing: 1.1,
          color: CupertinoColors.activeBlue),
    );
  }
}
