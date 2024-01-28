part of sign_in_page;

/// This is the password text field of the [SignInPage]
class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return DispatchTextField(
      hint: AppLocalizations.of(context)!.password,
      obscureText: false,
      onChanged: (String username) =>
          context.read<SignInCubit>().updatePassword(username),
    );
  }
}
