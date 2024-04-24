part of frame_card;

/*
  To-Dos:
  - [ ] Check/standardize blur
*/

/// The online indicator of the [FrameCard]
// ignore: unused_element
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
            padding: EdgeInsets.all(IOSTheme.of(context).spacing.small),
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                border: Border.all(
                  color: IOSTheme.of(context).colors.success,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: EdgeInsets.all(IOSTheme.of(context).spacing.small),
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
