part of welcome_modal;

/// This is the wrapper of the [WelcomeModal].
class _Wrapper extends StatelessWidget {
  const _Wrapper({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: IOSTheme.of(context).spacing.xSmall,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(IOSProperties.borderRadius),
        child: CupertinoPageScaffold(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                left: IOSTheme.of(context).spacing.xMedium,
                right: IOSTheme.of(context).spacing.xMedium,
                bottom: IOSTheme.of(context).spacing.xLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
