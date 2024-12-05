import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';

abstract class AddFrameRemoteDataSource {
  const AddFrameRemoteDataSource();

  Future<void> addFrame({
    required String qrCode,
    required String frameName,
    required AuthenticationToken accessToken,
  });
}

class AddFrameRemoteDataSourceImpl extends AddFrameRemoteDataSource {
  const AddFrameRemoteDataSourceImpl({
    required this.serverRemoteHandler,
  });

  final ServerRemoteHandler serverRemoteHandler;

  @override
  Future<void> addFrame({
    required String qrCode,
    required String frameName,
    required AuthenticationToken accessToken,
  }) {
    final Map<String, dynamic> requestBody = {
      "qr_code": qrCode,
      "frame_name": frameName,
    };

    return serverRemoteHandler.post(
      path: "/pair_frame",
      body: requestBody,
      accessToken: accessToken.token,
    );
  }
}
