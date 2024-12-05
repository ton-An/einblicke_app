part of add_frame_modal;

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.addFrameDescription,
      textAlign: TextAlign.center,
      style: CustomCupertinoTheme.of(context).text.body,
    );
  }
}
