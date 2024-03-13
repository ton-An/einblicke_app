import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter/cupertino.dart';

abstract class InAppNotificationState {
  const InAppNotificationState();
}

class InAppNotificationInitial extends InAppNotificationState {
  const InAppNotificationInitial();
}

class InAppNotificationInitiating extends InAppNotificationState {
  const InAppNotificationInitiating({required this.failure});

  final Failure failure;
}

class InAppNotificationDelivering extends InAppNotificationState {
  const InAppNotificationDelivering({required this.overlayEntry});

  final OverlayEntry overlayEntry;
}

class InAppNotificationDelivered extends InAppNotificationState {
  const InAppNotificationDelivered();
}

class InAppNotificationReplacing extends InAppNotificationState {
  const InAppNotificationReplacing();
}

class InAppNotificationDismissed extends InAppNotificationState {
  const InAppNotificationDismissed();
}