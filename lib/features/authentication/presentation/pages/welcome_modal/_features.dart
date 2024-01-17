part of welcome_modal;

/// This is the list of features of the [WelcomeModal]
class _Features extends StatelessWidget {
  const _Features();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DispatchProperties.smallPadding,
        vertical: DispatchProperties.mediumPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _FeatureTile(
            icon: CupertinoIcons.square_fill_line_vertical_square,
            title: AppLocalizations.of(context)!.loremTitle,
            description: AppLocalizations.of(context)!.loremDescription,
          ),
          _FeatureTile(
            icon: CupertinoIcons.square_fill_line_vertical_square,
            title: AppLocalizations.of(context)!.loremTitle,
            description: AppLocalizations.of(context)!.loremDescription,
          ),
          _FeatureTile(
            icon: CupertinoIcons.square_fill_line_vertical_square,
            title: AppLocalizations.of(context)!.loremTitle,
            description: AppLocalizations.of(context)!.loremDescription,
          ),
        ],
      ),
    );
  }
}
