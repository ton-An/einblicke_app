import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/select_frame/domain/usecases/get_paired_frames_info.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/select_frame_cubit/select_frame_states.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectFrameCubit extends Cubit<SelectFrameState> {
  SelectFrameCubit({required this.getPairedFramesInfo})
      : super(const SelectFrameInitialState());

  final GetPairedFramesInfo getPairedFramesInfo;

  void loadFrames() async {
    final Either<Failure, List<PairedFrameInfo>> pairedFramesInfoEither =
        await getPairedFramesInfo();

    pairedFramesInfoEither.fold((Failure failure) {
      emit(SelectFrameFailure(failure));
    }, (List<PairedFrameInfo> framesInfo) {
      emit(SelectFrameLoaded(framesInfo));
    });
  }
}
