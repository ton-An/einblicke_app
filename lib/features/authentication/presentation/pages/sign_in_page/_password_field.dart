part of login_page;

class _PasswordField extends StatelessWidget {
  const _PasswordField({super.key});

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
