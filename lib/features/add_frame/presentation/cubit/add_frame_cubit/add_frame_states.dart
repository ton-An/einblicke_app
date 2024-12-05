import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:equatable/equatable.dart';

abstract class AddFrameState extends Equatable {
  const AddFrameState();
}

class AddFrameInitial extends AddFrameState {
  const AddFrameInitial();

  @override
  List<Object> get props => [];
}

class AddFrameRecognized extends AddFrameState {
  const AddFrameRecognized();

  @override
  List<Object> get props => [];
}

class AddFrameLoading extends AddFrameState {
  const AddFrameLoading();

  @override
  List<Object> get props => [];
}

class AddFrameSuccessful extends AddFrameState {
  const AddFrameSuccessful();

  @override
  List<Object> get props => [];
}

class AddFrameFailure extends AddFrameState {
  const AddFrameFailure({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
