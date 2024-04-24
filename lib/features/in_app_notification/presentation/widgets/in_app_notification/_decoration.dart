part of in_app_notification;

class _Decroation extends StatelessWidget {
  const _Decroation({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: CustomCupertinoTheme.of(context)
                .colors
                .backgroundContrast
                .withOpacity(.11),
            blurRadius: 20,
            spreadRadius: 9,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          CustomCupertinoProperties.borderRadius,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: CustomCupertinoTheme.of(context)
                  .colors
                  .background
                  .withOpacity(.7),
              borderRadius:
                  BorderRadius.circular(CustomCupertinoProperties.borderRadius),
              border: Border.all(
                width: .3,
                color: CustomCupertinoTheme.of(context)
                    .colors
                    .border
                    .withOpacity(.3),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
