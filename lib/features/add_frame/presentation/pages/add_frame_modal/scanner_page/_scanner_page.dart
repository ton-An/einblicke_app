part of add_frame_modal;

class _ScannerPage extends StatelessWidget {
  const _ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            children: [
              const _CameraView(),
              const XXMediumGap(),
              const _ScannerTitle(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: CustomCupertinoTheme.of(context).spacing.xMedium,
                ),
                child: const Column(
                  children: [
                    MediumGap(),
                    _Description(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
