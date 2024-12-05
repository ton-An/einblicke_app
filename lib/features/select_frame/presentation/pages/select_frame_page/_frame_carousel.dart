part of select_frame_page;

/// The carousel for displaying the frames on the [SelectFramePage]
class _FrameCarousel extends StatefulWidget {
  const _FrameCarousel();

  @override
  State<_FrameCarousel> createState() => _FrameCarouselState();
}

class _FrameCarouselState extends State<_FrameCarousel> {
  final List<Widget> _frameCards = [];

  @override
  void initState() {
    super.initState();

    SelectFrameState state = context.read<SelectFrameCubit>().state;
    if (state is SelectFrameLoaded) {
      _preBuildFrameCards(state.frames);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectFrameCubit, SelectFrameState>(
      listener: (context, state) {
        if (state is SelectFrameLoaded) {
          _preBuildFrameCards(state.frames);
        }
      },
      child: FlutterCarousel.builder(
        itemCount: _frameCards.length,
        options: FlutterCarouselOptions(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          height: double.infinity,
          viewportFraction: 1,
          padEnds: true,
          indicatorMargin: CustomCupertinoTheme.of(context).spacing.xMedium,
          slideIndicator: CircularSlideIndicator(
            slideIndicatorOptions: SlideIndicatorOptions(
              currentIndicatorColor:
                  CustomCupertinoTheme.of(context).colors.backgroundContrast,
              indicatorBackgroundColor:
                  CustomCupertinoTheme.of(context).colors.disabledButton,
            ),
          ),
          floatingIndicator: false,
        ),
        itemBuilder: (context, i, _) {
          print("Length");
          print(_frameCards.length);
          return _frameCards[i];
        },
      ),
    );
  }

  /// Pre-builds the frame cards to avoid the frame cards being disposed when using the carousel
  void _preBuildFrameCards(List<PairedFrameInfo> frames) {
    _frameCards.clear();
    imageCache.clear();

    for (PairedFrameInfo frame in frames) {
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
            horizontal: CustomCupertinoTheme.of(context).spacing.xMedium,
          ),
          child: FrameCard(
            frameInfo: frame,
          ),
        ),
      );

      _frameCards.add(frameWidget);
    }

    _frameCards.add(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CustomCupertinoTheme.of(context).spacing.xMedium,
        ),
        child: AddFrameCard(),
      ),
    );

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
