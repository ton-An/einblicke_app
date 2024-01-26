part of select_frame_page;

class _OnlineIndicator extends StatelessWidget {
  const _OnlineIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: IOSTheme.of(context).colors.background.withOpacity(.37),
        borderRadius: BorderRadius.circular(40),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 6,
            sigmaY: 6,
          ),
          blendMode: BlendMode.srcATop,
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
