part of frame_card;

/*
  To-Dos:
  - [ ] Check/standardize animation values
  - [ ] Check/standardize shadow
*/

/// The wrapper for the [FrameCard] that adds a shadow and a tap animation.
class _Wrapper extends StatefulWidget {
  const _Wrapper({
    required this.child,
    required this.frameId,
  });

  final Widget child;
  final String frameId;

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
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(CustomCupertinoProperties.borderRadius * 2),
        child: GestureDetector(
          onTap: () {
            _controller.forward().then((_) => _controller.reverse());
            context.go(SelectImageModal.route, extra: widget.frameId);
          },
          child: SizedBox(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
