import 'package:dartz/dartz.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

abstract class AddFrameRepository {
  const AddFrameRepository();

  Future<Either<Failure, None>> addFrame({
    required String qrCode,
    required String frameName,
    required AuthenticationToken accessToken,
  });
}
