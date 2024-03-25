import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/select_frame/domain/repositories/select_frame_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// __Get Paired Frames Info__ gets a [List] of [PairedFrameInfo]
///
/// Returns:
/// - [List<PairedFrameInfo>]: a list of [PairedFrameInfo] objects.
///
/// Failures:
/// - [DatabaseReadFailure]
/// - [UnauthorizedFailure]
/// - {@macro converted_dio_exceptions}
class GetPairedFramesInfo {
  /// __Get Paired Frames Info__ gets a [List] of [PairedFrameInfo]
  const GetPairedFramesInfo({required this.selectFrameRepository});

  final SelectFrameRepository selectFrameRepository;

  /// __Get Paired Frames Info__ gets a [List] of [PairedFrameInfo]
  Future<Either<Failure, List<PairedFrameInfo>>> call() async {
    return await selectFrameRepository.getPairedFramesInfo();
  }
}
