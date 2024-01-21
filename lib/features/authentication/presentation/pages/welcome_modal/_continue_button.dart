part of welcome_modal;

/// This is the continue button of the [WelcomeModal].
/// If pressed it will finish the onboarding process.
class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  void onContinuePressed(BuildContext context) async {
    // final status = await Permission.storage.request();
    // print(status);
    // await Permission.photos.request().then((status) {
    //   print(status);
    //   if (status.isGranted) {
    //     context.pop();
    //   }
    // });
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return DispatchTextButton(
      text: AppLocalizations.of(context)!.continueLabel,
      onPressed: () => onContinuePressed(context),
    );
  }
}
