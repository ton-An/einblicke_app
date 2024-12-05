part of add_frame_modal;

class _NameTextField extends StatelessWidget {
  const _NameTextField();

  @override
  Widget build(BuildContext context) {
    return CustomCupertinoTextField(
        hint: AppLocalizations.of(context)!.frameName,
        onChanged: (String frameName) {
          context.read<AddFrameCubit>().updateFrameName(frameName: frameName);
        });
  }
}
