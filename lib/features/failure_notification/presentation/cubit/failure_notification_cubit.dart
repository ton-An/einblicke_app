import 'package:einblicke_app/features/failure_notification/presentation/cubit/failure_notification_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FailureNotificationCubit extends Cubit<FailureNotificationState> {
  FailureNotificationCubit() : super(FailureNotificationEntering());

  Future<void> setNotificationDelivered() async {
    emit(FailureNotificationDelivered());
  }

  Future<void> replaceNotification() async {
    emit(FailureNotificationReplaced());
    await Future.delayed(const Duration(milliseconds: 600));
  }
}
