part of sign_in_page;

/// This is the cover artwork of the [SignInPage]
class _CoverArtwork extends StatelessWidget {
  const _CoverArtwork();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/unlicensed/cover3.png",
      width: 240,
      height: 240,
      fit: BoxFit.contain,
    );
  }
}
