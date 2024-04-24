part of select_frame_page;

/// The carousel for displaying the frames on the [SelectFramePage]
class _FrameCarousel extends StatefulWidget {
  const _FrameCarousel({
    required this.frames,
  });

  final List<PairedFrameInfo> frames;

  @override
  State<_FrameCarousel> createState() => _FrameCarouselState();
}

class _FrameCarouselState extends State<_FrameCarousel> {
  final List<Widget> _frameCards = [];

  @override
  void initState() {
    super.initState();

    _preBuildFrameCards();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectFrameCubit, SelectFrameState>(
      listener: (context, state) {
        if (state is SelectFrameReloaded) {
          _preBuildFrameCards();
        }
      },
      child: FlutterCarousel.builder(
        itemCount: _frameCards.length,
        options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          height: double.infinity,
          viewportFraction: 1,
          padEnds: true,
          indicatorMargin: IOSTheme.of(context).spacing.xMedium,
          slideIndicator: CircularSlideIndicator(
            currentIndicatorColor:
                IOSTheme.of(context).colors.backgroundContrast,
            indicatorBackgroundColor:
                IOSTheme.of(context).colors.disabledButton,
          ),
          floatingIndicator: false,
        ),
        itemBuilder: (context, i, _) {
          return _frameCards[i];
        },
      ),
    );
  }

  /// Pre-builds the frame cards to avoid the frame cards being disposed when using the carousel
  void _preBuildFrameCards() {
    _frameCards.clear();
    imageCache.clear();

    for (PairedFrameInfo frame in widget.frames) {
      final SingleImageLoaderCubit singleImageLoaderCubit =
          getIt<SingleImageLoaderCubit>();

      singleImageLoaderCubit.loadFrameImage(
        frameId: frame.id,
      );

      singleImageLoaderCubit.stream.listen(
        (state) => _imageLoaderSubscription(
          state: state,
          frameImageLoaderCubit: singleImageLoaderCubit,
        ),
      );

      final Widget frameWidget = BlocProvider(
        key: UniqueKey(),
        create: (context) => singleImageLoaderCubit,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: IOSTheme.of(context).spacing.xMedium,
          ),
          child: FrameCard(
            frameInfo: frame,
          ),
        ),
      );

      _frameCards.add(frameWidget);
    }
    setState(() {});
  }

  /// Checks if the the [SingleImageLoaderCubit] has loaded the image and caches
  /// it or if it has failed and sends a failure notification
  void _imageLoaderSubscription({
    required FrameImageLoaderState state,
    required SingleImageLoaderCubit frameImageLoaderCubit,
  }) {
    if (state is FrameImagePreCacheLoaded) {
      precacheImage(MemoryImage(state.imageBytes), context).then((value) =>
          frameImageLoaderCubit.setFrameImageCached(state.imageBytes));
    }

    if (state is FrameImageLoaderFailure) {
      context
          .read<InAppNotificationCubit>()
          .sendFailureNotification(state.failure);
    }
  }
}
