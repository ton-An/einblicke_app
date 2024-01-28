part of select_frame_page;

class _Frame extends StatefulWidget {
  const _Frame({
    required this.title,
    required this.imgPath,
    required this.onPressed,
  });

  final String title;
  final String imgPath;
  final VoidCallback onPressed;

  @override
  State<_Frame> createState() => _FrameState();
}

class _FrameState extends State<_Frame> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _setUpAnimation();

    super.initState();
  }

  void _setUpAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 180),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: .85).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _animation.value,
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(DispatchProperties.borderRadius),
          child: GestureDetector(
            onTap: _onCardPressed,
            child: _buildCardContent(context),
          ),
        ),
      ),
    );
  }

  SizedBox _buildCardContent(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 270,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.imgPath,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              decoration: _gradientBackdrop(),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: _buildCardOverlay(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildCardOverlay(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            right: -9,
            top: 2,
            child: _OnlineIndicator(),
          ),
          Text(
            widget.title,
            style: IOSTheme.of(context).text.largeTitle.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  void _onCardPressed() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onPressed();
  }

  BoxDecoration _gradientBackdrop() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.transparent, Colors.black.withOpacity(0.2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}
