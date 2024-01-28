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
            padding: EdgeInsets.all(IOSTheme.of(context).spacing.xTiny),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                border: Border.all(
                  color: IOSTheme.of(context).colors.success,
                  width: 1,
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: EdgeInsets.all(IOSTheme.of(context).spacing.xTiny),
                decoration: BoxDecoration(
                  color: IOSTheme.of(context).colors.success,
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
