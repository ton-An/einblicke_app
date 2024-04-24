import 'dart:io';

import 'package:einblicke_shared/einblicke_shared.dart';

abstract class SelectImageState {
  const SelectImageState();
}

abstract class SelectImageStateWithFile extends SelectImageState {
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
  const SelectImageFailure({required this.failure});

  final Failure failure;
}
