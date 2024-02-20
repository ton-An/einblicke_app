import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

class IsSingnedIn {
  const IsSingnedIn({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  Future<Either<Failure, bool>> call() async {
    return await authenticationRepository.isTokenBundlePresent();
  }
}
