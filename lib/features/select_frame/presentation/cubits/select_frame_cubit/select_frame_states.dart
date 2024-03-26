import 'package:einblicke_shared/einblicke_shared.dart';

abstract class SelectFrameState {
  const SelectFrameState();
}

class SelectFrameInitialState extends SelectFrameState {
  const SelectFrameInitialState();
}

class SelectFrameLoaded extends SelectFrameState {
  final List<PairedFrameInfo> framesInfo;

  const SelectFrameLoaded(this.framesInfo);
}

class SelectFrameFailure extends SelectFrameState {
  final Failure failure;

  const SelectFrameFailure(this.failure);
}
