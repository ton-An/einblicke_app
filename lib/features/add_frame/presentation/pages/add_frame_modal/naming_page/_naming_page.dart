part of add_frame_modal;

class _NamingPage extends StatelessWidget {
  const _NamingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _NamingTitle(),
        XXMediumGap(),
        const _NameTextField(),
        XXMediumGap(),
        const _AddFrameButton(),
      ],
    );
  }
}
