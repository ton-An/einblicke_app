part of frame_card;

/// The overlay of the [FrameCard] which displays the title and online indicator.
class _Overlay extends StatelessWidget {
  const _Overlay({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            IOSTheme.of(context).colors.transparent,
            IOSTheme.of(context).colors.backgroundContrast.withOpacity(.2),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.all(IOSTheme.of(context).spacing.xxSmall),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // -- Online Indicator --
              // const Positioned(
              //   right: -9,
              //   top: 2,
              //   child: _OnlineIndicator(),
              // ),

              // -- Title --
              _Title(title: title)
            ],
          ),
        ),
      ),
    );
  }
}
