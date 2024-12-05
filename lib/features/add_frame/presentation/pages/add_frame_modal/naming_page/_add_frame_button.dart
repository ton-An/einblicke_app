part of add_frame_modal;

class _AddFrameButton extends StatelessWidget {
  const _AddFrameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCupertinoTextButton(
        text: AppLocalizations.of(context)!.addFrame,
        onPressed: () {
          context.read<AddFrameCubit>().addFrame();
        });
  }
}
