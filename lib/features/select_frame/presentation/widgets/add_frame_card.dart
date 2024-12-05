import 'package:einblicke_app/core/l10n/app_localizations.dart';
import 'package:einblicke_app/features/add_frame/presentation/pages/add_frame_modal/add_frame_modal.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AddFrameCard extends StatelessWidget {
  const AddFrameCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(AddFrameModal.route);
      },
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(CustomCupertinoProperties.borderRadius * 2),
        child: Container(
          color: CustomCupertinoTheme.of(context).colors.fieldColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.add_circled,
                  color: CustomCupertinoTheme.of(context).colors.text,
                ),
                SizedBox(
                    height: CustomCupertinoTheme.of(context).spacing.xSmall),
                Text(
                  AppLocalizations.of(context)!.addFrame,
                  style: CustomCupertinoTheme.of(context)
                      .text
                      .buttonLabel
                      .copyWith(
                        color: CustomCupertinoTheme.of(context).colors.text,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
