part of select_frame_page;

class _QuequeIndicator extends StatelessWidget {
  const _QuequeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: IOSTheme.of(context).colors.fieldColor,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(CupertinoIcons.rectangle_stack, size: 16),
          SizedBox(width: IOSTheme.of(context).spacing.small),
          Text("4", style: IOSTheme.of(context).text.smallLabel),
        ],
      ),
    );
  }
}
