part of select_frame_page;

class _Carousel extends StatelessWidget {
  const _Carousel({
    super.key,
    required this.frames,
  });

  final List<PairedFrameInfo> frames;

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: frames.length,
      options: CarouselOptions(
        enlargeCenterPage: true,
        viewportFraction: .6,
        scrollDirection: Axis.horizontal,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        showIndicator: false,
      ),
      itemBuilder: (context, i, _) {
        return BlocProvider(
          create: (context) => getIt<FrameImageLoaderCubit>(),
          child: Center(
            child: FrameCard(
              frameInfo: frames[i],
              onPressed: () {
                context.push(SelectImageModal.route);
              },
            ),
          ),
        );
      },
    );
  }
}
