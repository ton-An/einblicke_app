import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/add_frame/domain/usecases/add_frame.dart';
import 'package:einblicke_app/features/add_frame/presentation/cubit/add_frame_cubit/add_frame_states.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFrameCubit extends Cubit<AddFrameState> {
  AddFrameCubit({required this.addFrameUsecase})
      : super(const AddFrameInitial());

  final AddFrame addFrameUsecase;

  String? qrCode;
  String frameName = "";

  void recognizeFrame({required String qrCode}) {
    if (state is AddFrameRecognized) return;

    this.qrCode = qrCode;

    emit(const AddFrameRecognized());
  }

  void addFrame() async {
    if (frameName.length < 3) {
      emit(const AddFrameFailure(
        failure: NameTooShortFailure(),
      ));
      return;
    }

    emit(const AddFrameLoading());

    final Either<Failure, None> addFrameEither = await addFrameUsecase(
      qrCode: qrCode!,
      frameName: frameName,
    );

    addFrameEither.fold(
      (Failure failure) {
        emit(AddFrameFailure(failure: failure));
      },
      (None none) {
        emit(const AddFrameSuccessful());
      },
    );
  }

  void updateFrameName({required String frameName}) {
    this.frameName = frameName;
  }
}
