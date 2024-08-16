import 'package:einblicke_app/core/widgets/custom_cupertino_modal/custom_cupertino_modal.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_small_text_button.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';
import 'package:flutter/material.dart';

/// __Custom Cupertino Modal Top Bar__
///
/// A top bar for the [CustomCupertinoModal] that can have a leading button and a title.
class CustomCupertinoModalTopBar extends StatelessWidget {
  const CustomCupertinoModalTopBar({
    super.key,
    this.leadingTextButton,
    this.title,
  });

  final CustomCupertinoSmallTextButton? leadingTextButton;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: CustomCupertinoTheme.of(context).spacing.xSmall,
        right: CustomCupertinoTheme.of(context).spacing.xSmall,
        top: CustomCupertinoTheme.of(context).spacing.xSmall,
        bottom: CustomCupertinoTheme.of(context).spacing.xxMedium,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: leadingTextButton ?? const SizedBox(),
            ),
          ),
          Expanded(
            flex: 2,
            child: title != null
                ? Center(
                    child: Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: CustomCupertinoTheme.of(context)
                          .text
                          .buttonLabel
                          .copyWith(
                            color: CustomCupertinoTheme.of(context).colors.text,
                          ),
                    ),
                  )
                : const SizedBox(),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
