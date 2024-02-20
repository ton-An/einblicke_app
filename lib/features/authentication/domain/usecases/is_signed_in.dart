import 'package:dartz/dartz.dart';
import 'package:dispatch_pi_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dispatch_pi_shared/dispatch_pi_shared.dart';

class IsSingnedIn {
  const IsSingnedIn({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  Future<Either<Failure, bool>> call() async {
    return await authenticationRepository.isTokenBundlePresent();
  }
}
