import 'dart:ui';

import 'package:dispatch_pi_app/core/ios_properties.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/medium_gap.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/small_gap.dart';
import 'package:flutter/cupertino.dart';

/*
  To-Dos:
  - [ ] Implement this screen and clean up
*/

class PopOverNotification extends StatelessWidget {
  const PopOverNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: IOSTheme.of(context).spacing.medium,
            vertical: IOSTheme.of(context).spacing.small,
          ),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.14),
                blurRadius: 10,
                offset: const Offset(0, 1),
              )
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                IOSProperties.borderRadius,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 6,
                  sigmaY: 6,
                  tileMode: TileMode.mirror,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(.7)),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: IOSTheme.of(context).spacing.xMedium,
                    vertical: IOSTheme.of(context).spacing.medium,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.exclamationmark_triangle,
                        color: IOSTheme.of(context).colors.error,
                        size: 24,
                      ),
                      const MediumGap(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Authentication Failure",
                              style: IOSTheme.of(context)
                                  .text
                                  .buttonLabel
                                  .copyWith(
                                      color:
                                          IOSTheme.of(context).colors.error)),
                          const SmallGap(),
                          Text(
                            "Please sign in again",
                            style: IOSTheme.of(context).text.body,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension OverlayExtension on BuildContext {
  void insertOverlay() => Overlay.of(this).insert(
        OverlayEntry(
          builder: (context) => const PopOverNotification(),
        ),
      );
}
