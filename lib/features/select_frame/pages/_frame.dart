part of select_frame_page;

class _Frame extends StatefulWidget {
  const _Frame({
    super.key,
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
    _controller = AnimationController(
        duration: const Duration(milliseconds: 120),
        reverseDuration: const Duration(milliseconds: 180),
        vsync: this);
    _animation = Tween<double>(begin: 1, end: .85).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
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
          borderRadius: BorderRadius.circular(10),
          child: GestureDetector(
            onTap: () {
              _controller.forward().then((_) => _controller.reverse());
              widget.onPressed();
            },
            child: SizedBox(
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
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.2)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Text(
                                  widget.title,
                                  style: IOSTheme.of(context)
                                      .text
                                      .largeTitle
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                const Positioned(
                                  right: -9,
                                  top: 1,
                                  child: const _OnlineIndicator(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
