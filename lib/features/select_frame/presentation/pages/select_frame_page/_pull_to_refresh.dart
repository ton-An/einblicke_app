part of select_frame_page;

class _PullToRefresh extends StatefulWidget {
  const _PullToRefresh({
    required this.child,
  });

  final Widget child;

  @override
  State<_PullToRefresh> createState() => _PullToRefreshState();
}

class _PullToRefreshState extends State<_PullToRefresh>
    with SingleTickerProviderStateMixin {
  double _dragDistance = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation =
        CurvedAnimation(parent: _animationController, curve: Sprung(40))
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectFrameCubit, SelectFrameState>(
      listener: (context, state) {
        if (state is SelectFrameReloaded) {
          _animationController.animateTo(0);
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              dragStartBehavior: DragStartBehavior.start,
              onVerticalDragStart: _onVerticalDragStart,
              onVerticalDragUpdate: _onVerticalDragUpdate,
              onVerticalDragEnd: _onVerticalDragEnd,
              child: widget.child,
            ),
          ),

          // -- Pull to refresh --
          Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: Offset(
                0,
                _animation.value * 100 - 35,
              ),
              child: const Loader(),
            ),
          ),
        ],
      ),
    );
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _dragDistance = 0;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    _dragDistance += details.primaryDelta!;
    final double newControllerValue = (_dragDistance / 400).clamp(0, 1);

    _animationController.value = newControllerValue;
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_animationController.value > .9) {
      context.read<SelectFrameCubit>().reloadFrames();
    } else {
      _animationController.animateTo(0);
    }
  }
}
