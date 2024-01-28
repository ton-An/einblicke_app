part of select_image_modal;

/// The send button of the [_ImagePicker] which initiates
/// the server request to send an image to the selected frame.
class _SendImageButton extends StatelessWidget {
  const _SendImageButton();

  void onSendImagePressed(BuildContext context) {
    context.read<SelectImageCubit>().sendImage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectImageCubit, SelectImageState>(
      builder: (context, state) {
        if (state is SelectImageInitial) {
          return DispatchTextButton(
            text: AppLocalizations.of(context)!.sendImage,
          );
        }

        if (state is SelectImageLoading) {
          return const DispatchButton(child: CupertinoActivityIndicator());
        }

        if (state is SelectImageSuccess) {
          return DispatchTextButton(
            text: AppLocalizations.of(context)!.success,
            disabledColor: IOSTheme.of(context).colors.success,
          );
        }

        if (state is SelectImageFailure) {
          return DispatchTextButton(
            text: AppLocalizations.of(context)!.error,
            disabledColor: IOSTheme.of(context).colors.error,
          );
        }

        return DispatchTextButton(
          text: AppLocalizations.of(context)!.sendImage,
          onPressed: () => onSendImagePressed(context),
        );
      },
    );
  }
}
