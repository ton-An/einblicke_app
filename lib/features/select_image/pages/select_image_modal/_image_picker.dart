part of select_image_page;

class _ImagePicker extends StatelessWidget {
  const _ImagePicker({super.key});

  void onImageSelectorPressed(BuildContext context) async {
    await getIt<ImagePicker>()
        .pickImage(source: ImageSource.gallery)
        .then((image) async {
      await ImageCropper()
          .cropImage(
        sourcePath: image!.path,
        aspectRatio: CropAspectRatio(ratioX: 5, ratioY: 3),
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
              child: ColoredBox(
                color: IOSTheme.of(context).colors.fieldColor,
                child: const Center(
                  child: Icon(
                    CupertinoIcons.add,
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
