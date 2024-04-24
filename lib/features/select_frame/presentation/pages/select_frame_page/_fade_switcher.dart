part of select_frame_page;

/// Used to fade between the loader and the frames on the [SelectFramePage]
class _FadeSwitcher extends StatelessWidget {
  const _FadeSwitcher({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: child);
  }
}
