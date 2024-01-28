part of frame_card;

/// The wrapper for the [FrameCard] that adds a shadow and a tap animation.
class _Wrapper extends StatefulWidget {
  const _Wrapper({
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  State<_Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<_Wrapper>
    with SingleTickerProviderStateMixin {
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
            onTap: () {
              _controller.forward().then((_) => _controller.reverse());
              widget.onPressed();
            },
            child: SizedBox(
              width: 200,
              height: 270,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
