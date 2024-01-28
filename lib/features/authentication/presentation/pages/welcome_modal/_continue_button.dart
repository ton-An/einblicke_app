part of welcome_modal;

/// This is the continue button of the [WelcomeModal].
///
/// If pressed, it will request the required permissions and
/// continue to the sign in page.
class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  void onContinuePressed(BuildContext context) async {
    await Permission.photos.request().then((status) {
      if (status.isGranted) {
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IOSTextButton(
      text: AppLocalizations.of(context)!.continueLabel,
      onPressed: () => onContinuePressed(context),
    );
  }
}
