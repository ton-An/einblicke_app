part of add_frame_modal;

class _NamingTitle extends StatelessWidget {
  const _NamingTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.nameTheFrame,
      style: CustomCupertinoTheme.of(context).text.largeTitle,
    );
  }
}
