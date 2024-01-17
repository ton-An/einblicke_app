import 'dart:io';

abstract class SelectImageState {
  const SelectImageState();
}

class SelectImageStateWithFile extends SelectImageState {
  const SelectImageStateWithFile({required this.image});
  final File image;
}

class SelectImageInitial extends SelectImageState {
  const SelectImageInitial();
}

class SelectImagePicked extends SelectImageStateWithFile {
  const SelectImagePicked({required super.image});
}

class SelectImageLoading extends SelectImageStateWithFile {
  const SelectImageLoading({required super.image});
}

class SelectImageSuccess extends SelectImageStateWithFile {
  const SelectImageSuccess({required super.image});
}

class SelectImageFailure extends SelectImageState {
  const SelectImageFailure();
}

class SelectImageAuthFailure extends SelectImageFailure {
  const SelectImageAuthFailure();
}
