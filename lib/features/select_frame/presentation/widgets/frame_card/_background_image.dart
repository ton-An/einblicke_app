part of frame_card;

/// The background image of the [FrameCard]
class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({required this.imgPath});

  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imgPath,
      fit: BoxFit.cover,
    );
  }
}
