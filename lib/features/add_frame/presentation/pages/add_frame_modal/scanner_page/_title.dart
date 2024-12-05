part of add_frame_modal;

class _ScannerTitle extends StatelessWidget {
  const _ScannerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.addFrame,
      textAlign: TextAlign.center,
      style: CustomCupertinoTheme.of(context).text.largeTitle,
    );
  }
}
