part of select_frame_page;

/// The content of the loaded [SelectFramePage]
class _LoadedFrames extends StatelessWidget {
  const _LoadedFrames();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: CustomCupertinoTheme.of(context).spacing.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -- Title --
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CustomCupertinoTheme.of(context).spacing.xMedium,
            ),
            child: Text(
              AppLocalizations.of(context)!.yourFrames,
              style: CustomCupertinoTheme.of(context).text.largeTitle,
            ),
          ),
          const XMediumGap(),

          // -- Frame Carousel --
          Expanded(child: _FrameCarousel()),
        ],
      ),
    );
  }
}
