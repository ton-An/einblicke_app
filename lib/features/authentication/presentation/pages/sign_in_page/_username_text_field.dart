part of sign_in_page;

/// This is the username text field of the [SignInPage]
class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField();

  @override
  Widget build(BuildContext context) {
    return CustomCupertinoTextField(
      hint: AppLocalizations.of(context)!.username,
      // hint: "Email or Phone Number",
      onChanged: (String username) =>
          context.read<SignInCubit>().updateUsername(username),
    );
  }
}
