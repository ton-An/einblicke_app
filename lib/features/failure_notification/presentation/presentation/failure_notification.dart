import 'dart:ui';

import 'package:einblicke_app/core/ios_properties.dart';
import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:einblicke_app/core/widgets/gaps/medium_gap.dart';
import 'package:einblicke_app/core/widgets/gaps/small_gap.dart';
import 'package:einblicke_app/features/failure_notification/presentation/cubit/failure_notification_cubit.dart';
import 'package:einblicke_app/features/failure_notification/presentation/cubit/failure_notification_states.dart';
import 'package:einblicke_app/features/failure_notification/presentation/presentation/einblicke_dismissible.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
  To-Dos:
  - [ ] Implement this screen and clean up
*/

class FailureNotification extends StatefulWidget {
  const FailureNotification({
    required this.failure,
    required this.onDismissed,
    super.key,
  });

  final Failure failure;
  final VoidCallback onDismissed;

  @override
  State<FailureNotification> createState() => _FailureNotificationState();
}

class _FailureNotificationState extends State<FailureNotification>
    with SingleTickerProviderStateMixin {
  late Animation _replacementAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {});
    });
    _replacementAnimation =
        _controller.drive(Tween<double>(begin: 1, end: 0).chain(CurveTween(
      curve: Curves.easeOut,
    )));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FailureNotificationCubit, FailureNotificationState>(
      listener: (context, state) {
        if (state is FailureNotificationReplaced) {
          _controller.forward();
        }
      },
      child: Opacity(
        opacity: _replacementAnimation.value,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EinblickeDismissible(
              dismissThreshold: .17,
              onDismissed: () => widget.onDismissed(),
              movementDuration: const Duration(milliseconds: 450),
              reverseMovementDuration: const Duration(milliseconds: 2000),
              entryDuration: const Duration(milliseconds: 800),
              key: GlobalKey(),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: IOSTheme.of(context).spacing.medium,
                    vertical: IOSTheme.of(context).spacing.small,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(.08),
                          blurRadius: 20,
                          spreadRadius: 9,
                          // offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        IOSProperties.borderRadius,
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(.7)),
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
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.failure.name,
                                      style: IOSTheme.of(context)
                                          .text
                                          .buttonLabel
                                          .copyWith(
                                            color: IOSTheme.of(context)
                                                .colors
                                                .error,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SmallGap(),
                                    Text(
                                      widget.failure.message,
                                      style: IOSTheme.of(context).text.body,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
