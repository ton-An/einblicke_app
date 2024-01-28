part of frame_card;

/// The title of the [FrameCard]
class _Title extends StatelessWidget {
  const _Title({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: IOSTheme.of(context).text.largeTitle.copyWith(
            color: Colors.white,
          ),
    );
  }
}
