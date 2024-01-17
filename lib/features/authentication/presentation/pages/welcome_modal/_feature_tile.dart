part of welcome_modal;

/// This is a single feature tile of the [WelcomeModal]
///
/// Main contents:
/// - Icon
/// - Title
/// - Description
class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  /// The icon of the tile. It is placed on the left side.
  final IconData icon;

  /// The title of the tile
  final String title;

  /// The description of the tile
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: IOSTheme.of(context).spacing.medium,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: DispatchProperties.largeIconSize,
          ),
          SizedBox(width: IOSTheme.of(context).spacing.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: IOSTheme.of(context).text.navTitle,
                ),
                const SmallerGap(),
                Text(
                  description,
                  style: IOSTheme.of(context).text.description,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
