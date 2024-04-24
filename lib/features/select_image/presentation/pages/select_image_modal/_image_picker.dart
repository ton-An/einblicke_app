part of select_image_modal;

/*
  To-Do:
    - [ ] Untangle the spaghetti
*/

/// The image picker of the [SelectImageModal] which allows the user
/// to select an image from their device.
class _ImagePicker extends StatefulWidget {
  const _ImagePicker();

  @override
  State<_ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<_ImagePicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 120),
        reverseDuration: const Duration(milliseconds: 180),
        vsync: this);
    _animation = Tween<double>(begin: 1, end: .6).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(IOSProperties.borderRadius),
      child: SizedBox(
        width: double.infinity,
        child: BlocBuilder<SelectImageCubit, SelectImageState>(
          builder: (context, state) {
            if (state is SelectImageStateWithFile) {
              return Image.file(
                state.image,
                fit: BoxFit.cover,
              );
            }

            return GestureDetector(
              onTap: () => _onImageSelectorPressed(context),
              child: Opacity(
                opacity: _animation.value,
                child: ColoredBox(
                  color: IOSTheme.of(context).colors.fieldColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.add,
                      ),
                      const SmallGap(),
                      Text(
                        AppLocalizations.of(context)!.selectImage,
                        style: IOSTheme.of(context).text.body.copyWith(
                              color: IOSTheme.of(context).colors.primary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onImageSelectorPressed(BuildContext context) async {
    _controller.forward().then((_) => _controller.reverse());
    await getIt<ImagePicker>()
        .pickImage(source: ImageSource.gallery)
        .then((XFile? image) async {
      if (image == null) return;

      await ImageCropper().cropImage(
        uiSettings: [
          IOSUiSettings(
            rotateButtonsHidden: true,
            aspectRatioPickerButtonHidden: true,
            resetButtonHidden: true,
            aspectRatioLockEnabled: true,
          )
        ],
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 5, ratioY: 3),
      ).then((CroppedFile? croppedImage) {
        if (croppedImage == null) return;

        context.read<SelectImageCubit>().selectImage(File(croppedImage!.path));
      });
    });
  }
}
