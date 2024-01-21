part of sign_in_page;

class _UsernameField extends StatelessWidget {
  const _UsernameField({super.key});

  @override
  Widget build(BuildContext context) {
    return DispatchTextField(
      hint: AppLocalizations.of(context)!.username,
      onChanged: (String username) =>
          context.read<SignInCubit>().updateUsername(username),
    );
  }
}
