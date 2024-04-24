import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/select_image/domain/usecases/send_image.dart';
import 'package:einblicke_app/features/select_image/presentation/cubits/select_image_states.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectImageCubit extends Cubit<SelectImageState> {
  SelectImageCubit({
    required this.sendImageUsecase,
  }) : super(const SelectImageInitial());

  final SendImage sendImageUsecase;

  late File selectedImage;

  void selectImage(File image) {
    selectedImage = image;

    emit(SelectImagePicked(image: selectedImage));
  }

  void sendImage({required String frameId}) async {
    emit(SelectImageLoading(image: selectedImage));

    final Either<Failure, None> sendImageEither = await sendImageUsecase(
      frameId: frameId,
      imagePath: selectedImage.path,
    );

    sendImageEither.fold(
      (Failure failure) => emit(SelectImageFailure(failure: failure)),
      (_) {
        emit(SelectImageSuccess(image: selectedImage));
        _resetForm();
      },
    );
  }

  void _resetForm() async {
    await Future.delayed(const Duration(milliseconds: 1400));
    emit(const SelectImageInitial());
  }
}
