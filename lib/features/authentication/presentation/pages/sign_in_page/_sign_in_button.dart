part of sign_in_page;

/*
  To-Dos:
  - [ ] Add fade transitions (maybe)
*/

/// This is the sign in button of the [SignInPage].
///
/// If pressed it will trigger a sign in request and
/// redirect the user to the [SelectFramePage] if successful.
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
          return const CustomCupertinoButton(
            child: CupertinoActivityIndicator(),
          );
        }

        return CustomCupertinoTextButton(
          text: AppLocalizations.of(context)!.continueLabel,
          onPressed: () => onLoginPressed(context),
        );
      },
    );
  }
}
