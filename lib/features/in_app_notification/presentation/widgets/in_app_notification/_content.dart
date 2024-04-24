part of in_app_notification;

class _Content extends StatelessWidget {
  const _Content({
    required this.failure,
  });

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          CupertinoIcons.exclamationmark_triangle,
          color: IOSTheme.of(context).colors.error,
          size: 24,
        ),
        const MediumGap(),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                failure.name,
                style: IOSTheme.of(context).text.buttonLabel.copyWith(
                      color: IOSTheme.of(context).colors.error,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
              const SmallGap(),
              Text(
                failure.message,
                style: IOSTheme.of(context).text.body,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
