part of sign_in_page;

/// This is the continue button of the [SignIn].
/// If pressed it will finish the onboarding process.
class _SignInButton extends StatelessWidget {
  const _SignInButton();

  void onLoginPressed(BuildContext context) {
    context.read<SignInCubit>().signIn();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        if (state is SignInLoading) {
          return const DispatchButton(
            child: CupertinoActivityIndicator(),
          );
        }

        if (state is SignInFailure) {
          return DispatchTextButton(
            text: AppLocalizations.of(context)!.error,
            disabledColor: IOSTheme.of(context).colors.error,
          );
        }

        return DispatchTextButton(
          text: AppLocalizations.of(context)!.login,
          onPressed: () => onLoginPressed(context),
        );
      },
    );
  }
}
