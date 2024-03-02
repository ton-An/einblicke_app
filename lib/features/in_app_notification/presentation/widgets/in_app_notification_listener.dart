import 'package:einblicke_app/features/in_app_notification/presentation/cubit/in_app_notification_cubit.dart';
import 'package:einblicke_app/features/in_app_notification/presentation/cubit/in_app_notification_states.dart';
import 'package:einblicke_app/features/in_app_notification/presentation/widgets/in_app_notification/in_app_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// __In App Notification Listener__ manages the overlay for [InAppNotification]s and
/// works in conjunction with [InAppNotificationCubit]
class InAppNotificationListener extends StatelessWidget {
  const InAppNotificationListener({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InAppNotificationCubit, InAppNotificationState>(
      listener: (context, state) {
        if (state is InAppNotificationInitiating) {
          final OverlayEntry overlayEntry = OverlayEntry(
            builder: (context) {
              return InAppNotification(
                failure: state.failure,
              );
            },
          );
          context.read<InAppNotificationCubit>().deliverNotification(
                overlayEntry: overlayEntry,
              );
        }

        if (state is InAppNotificationDelivering) {
          Overlay.of(context).insert(state.overlayEntry);
        }
      },
      child: child,
    );
  }
}
