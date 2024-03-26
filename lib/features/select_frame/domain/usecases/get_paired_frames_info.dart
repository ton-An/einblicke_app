import 'package:dartz/dartz.dart';
import 'package:einblicke_app/core/domain/usecases/server_auth_wrapper.dart';
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
  const GetPairedFramesInfo({
    required this.selectFrameRepository,
    required this.serverAuthWrapper,
  });

  final SelectFrameRepository selectFrameRepository;
  final ServerAuthWrapper<List<PairedFrameInfo>> serverAuthWrapper;

  /// __Get Paired Frames Info__ gets a [List] of [PairedFrameInfo]
  Future<Either<Failure, List<PairedFrameInfo>>> call() async {
    return serverAuthWrapper(
      serverCall: (accessToken) =>
          selectFrameRepository.getPairedFramesInfo(accessToken: accessToken),
    );
  }
}
