part of welcome_modal;

/*
  To-Dos:
  - [ ] Design a proper cover artwork
*/

/// This is the cover artwork of the [WelcomeModal]
class _CoverArtwork extends StatelessWidget {
  const _CoverArtwork();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/unlicensed/cover.png",
      width: 240,
      height: 292,
      fit: BoxFit.contain,
    );
  }
}
