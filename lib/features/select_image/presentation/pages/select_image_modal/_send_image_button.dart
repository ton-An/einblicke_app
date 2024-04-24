part of select_image_modal;

/*
  To-Do:
    - [ ] Simplify the different states
    - [ ] Add transition (e.g. a fade using [AnimatedContainer])
*/

/// The send button of the [_ImagePicker] which initiates
/// the server request to send an image to the selected frame.
class _SendImageButton extends StatelessWidget {
  const _SendImageButton({required this.frameId});

  final String frameId;

  void onSendImagePressed(BuildContext context) {
    context.read<SelectImageCubit>().sendImage(frameId: frameId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectImageCubit, SelectImageState>(
      builder: (context, state) {
        if (state is SelectImageInitial) {
          return CustomCupertinoTextButton(
            text: AppLocalizations.of(context)!.sendImage,
          );
        }

        if (state is SelectImageLoading) {
          return const CustomCupertinoButton(
              child: CupertinoActivityIndicator());
        }

        if (state is SelectImageSuccess) {
          return CustomCupertinoButton(
            disabledColor: CustomCupertinoTheme.of(context).colors.success,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Icon(
                CupertinoIcons.check_mark_circled_solid,
                size: 22,
              ),
            ),
          );
        }

        if (state is SelectImageFailure) {
          return CustomCupertinoButton(
            disabledColor: CustomCupertinoTheme.of(context).colors.error,
            child: const Icon(CupertinoIcons.xmark_circle_fill),
          );
        }

        return CustomCupertinoTextButton(
          text: AppLocalizations.of(context)!.sendImage,
          onPressed: () => onSendImagePressed(context),
        );
      },
    );
  }
}
