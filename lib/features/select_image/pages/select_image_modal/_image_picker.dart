part of select_image_modal;

/// The image picker of the [SelectImageModal] which allows the user
/// to select an image from their device.
class _ImagePicker extends StatefulWidget {
  const _ImagePicker({super.key});

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

  void onImageSelectorPressed(BuildContext context) async {
    _controller.forward().then((_) => _controller.reverse());
    await getIt<ImagePicker>()
        .pickImage(source: ImageSource.gallery)
        .then((image) async {
      await ImageCropper()
          .cropImage(
        sourcePath: image!.path,
        aspectRatio: const CropAspectRatio(ratioX: 5, ratioY: 3),
      )
          .then((CroppedFile? croppedImage) {
        context.read<SelectImageCubit>().selectImage(File(croppedImage!.path));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double displayWidth = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: displayWidth * .8,
        height: 400,
        child: BlocBuilder<SelectImageCubit, SelectImageState>(
          builder: (context, state) {
            if (state is SelectImageStateWithFile) {
              return Image.file(
                state.image,
                fit: BoxFit.cover,
              );
            }

            return GestureDetector(
              onTap: () => onImageSelectorPressed(context),
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
                        "Add Image",
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
}
