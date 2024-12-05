import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/add_frame/domain/repositories/add_frame_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

class AddFrame {
  const AddFrame(
      {required this.serverAuthWrapper, required this.addFrameRepository});

  final ServerAuthWrapper<None> serverAuthWrapper;
  final AddFrameRepository addFrameRepository;

  Future<Either<Failure, None>> call({
    required String qrCode,
    required String frameName,
  }) async {
    return serverAuthWrapper(
      serverCall: (accessToken) => addFrameRepository.addFrame(
        qrCode: qrCode,
        frameName: frameName,
        accessToken: accessToken,
      ),
    );
  }
}
