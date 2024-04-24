part of frame_card;

/// The background image of the [FrameCard]
class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleImageLoaderCubit, FrameImageLoaderState>(
      builder: (context, state) {
        return Container(
          color: IOSTheme.of(context).colors.background,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 550),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: state is FrameImageLoaded
                ? SizedBox(
                    height: double.infinity,
                    child: Image.memory(
                      state.imageBytes,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                      cacheHeight: 2000,
                    ),
                  )
                : const Center(child: CupertinoActivityIndicator()),
          ),
        );
      },
    );
  }
}
