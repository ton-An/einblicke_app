import 'dart:typed_data';

import 'package:einblicke_shared/einblicke_shared.dart';

abstract class FrameImageLoaderState {
  const FrameImageLoaderState();
}

class FrameImageLoaderInitial extends FrameImageLoaderState {
  const FrameImageLoaderInitial();
}

class FrameImagePreCacheLoaded extends FrameImageLoaderState {
  final Uint8List imageBytes;

  const FrameImagePreCacheLoaded({required this.imageBytes});
}

class FrameImageLoaded extends FrameImageLoaderState {
  final Uint8List imageBytes;

  const FrameImageLoaded({required this.imageBytes});
}

class FrameImageLoaderFailure extends FrameImageLoaderState {
  final Failure failure;

  const FrameImageLoaderFailure({required this.failure});
}
