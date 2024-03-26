part of frame_card;

/// The background image of the [FrameCard]
class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({required this.imageBytes});

  final Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      imageBytes,
      fit: BoxFit.cover,
    );
  }
}
