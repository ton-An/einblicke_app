part of frame_card;

/// The online indicator of the [FrameCard]
class _OnlineIndicator extends StatelessWidget {
  const _OnlineIndicator();

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: ColoredBox(
        color: IOSTheme.of(context).colors.background.withOpacity(.37),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 6,
            sigmaY: 6,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                border: Border.all(
                  color: CupertinoColors.activeGreen,
                  width: 1,
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: CupertinoColors.activeGreen,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
