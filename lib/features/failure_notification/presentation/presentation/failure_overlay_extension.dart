import 'package:einblicke_app/features/failure_notification/presentation/cubit/failure_notification_cubit.dart';
import 'package:einblicke_app/features/failure_notification/presentation/presentation/failure_notification.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension FailureOverlayExtension on BuildContext {
  static OverlayEntry? failureNotificationEntry;
  static Widget? failureNotificationWidget;
  static FailureNotificationCubit? failureNotificationCubit;

  void showFailureNotification(Failure failure) async {
    if (failureNotificationEntry == null) {
      failureNotificationCubit = FailureNotificationCubit();
      failureNotificationWidget = BlocProvider<FailureNotificationCubit>(
        create: (context) => failureNotificationCubit!,
        child: FailureNotification(
          failure: failure,
          onDismissed: () {
            failureNotificationEntry!.remove();
            failureNotificationEntry = null;
          },
        ),
      );

      failureNotificationEntry = OverlayEntry(builder: (context) {
        return failureNotificationWidget!;
      });

      Overlay.of(this).insert(
        failureNotificationEntry!,
      );
    } else {
      await failureNotificationCubit!.replaceNotification();
      failureNotificationEntry!.remove();
      failureNotificationEntry = null;
      showFailureNotification(failure);
    }
  }
}
