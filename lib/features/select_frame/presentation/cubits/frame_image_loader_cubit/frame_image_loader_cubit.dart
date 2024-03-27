import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/select_frame/domain/usecases/get_most_recent_image_of_frame.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/frame_image_loader_cubit/frame_image_loader_states.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FrameImageLoaderCubit extends Cubit<FrameImageLoaderState> {
  FrameImageLoaderCubit({
    required this.getMostRecentImageOfFrame,
  }) : super(const FrameImageLoaderInitial());

  final GetMostRecentImageOfFrame getMostRecentImageOfFrame;

  Future<void> loadFrameImage({
    required String frameId,
  }) async {
    final Either<Failure, Uint8List> imageBytesEither =
        await getMostRecentImageOfFrame(frameId: frameId);
    imageBytesEither.fold(
      (failure) => emit(FrameImageLoaderFailure(failure: failure)),
      (imageBytes) => emit(FrameImagePreCacheLoaded(imageBytes: imageBytes)),
    );
  }

  void setFrameImageCached(Uint8List imageBytes) {
    emit(FrameImageLoaded(imageBytes: imageBytes));
  }
}
