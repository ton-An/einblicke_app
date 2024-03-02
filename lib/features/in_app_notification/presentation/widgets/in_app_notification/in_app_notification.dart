library in_app_notification;

import 'dart:ui';

import 'package:einblicke_app/core/ios_properties.dart';
import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:einblicke_app/core/widgets/gaps/medium_gap.dart';
import 'package:einblicke_app/core/widgets/gaps/small_gap.dart';
import 'package:einblicke_app/features/in_app_notification/presentation/cubit/in_app_notification_cubit.dart';
import 'package:einblicke_app/features/in_app_notification/presentation/cubit/in_app_notification_states.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '_content.dart';
part '_decoration.dart';
part '_dismissible.dart';
part '_fade_wrapper.dart';

/*
  To-Dos:
  - [ ] Implement this screen and clean up
  - [ ] Clear up naming of the whole in app notification feature
*/

/// __In App Notification__ builds an in app notification wich displays a [Failure]
class InAppNotification extends StatelessWidget {
  const InAppNotification({
    required this.failure,
    super.key,
  });

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return _FadeWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Dismissible(
            dismissThreshold: .17,
            onDismissed: () =>
                context.read<InAppNotificationCubit>().dismissNotification(),
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
                child: _Decroation(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: IOSTheme.of(context).spacing.xMedium,
                      vertical: IOSTheme.of(context).spacing.medium,
                    ),
                    child: _Content(
                      failure: failure,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
