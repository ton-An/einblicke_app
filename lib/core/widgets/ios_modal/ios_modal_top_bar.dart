import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:einblicke_app/core/widgets/ios_modal/ios_modal.dart';
import 'package:einblicke_app/core/widgets/ios_small_text_button.dart';
import 'package:flutter/material.dart';

/// __IOS Modal Top Bar__
///
/// A top bar for the [IOSModal] that can have a leading button and a title.
class IOSModalTopBar extends StatelessWidget {
  const IOSModalTopBar({
    super.key,
    this.leadingTextButton,
    this.title,
  });

  final IOSSmallTextButton? leadingTextButton;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: IOSTheme.of(context).spacing.xSmall,
        right: IOSTheme.of(context).spacing.xSmall,
        top: IOSTheme.of(context).spacing.xSmall,
        bottom: IOSTheme.of(context).spacing.xxMedium,
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
                      style: IOSTheme.of(context).text.buttonLabel.copyWith(
                            color: IOSTheme.of(context).colors.text,
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
