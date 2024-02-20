import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template sign_out}
/// Signs  the user out by deleting their tokens
///
/// Failures:
/// - TBD
/// {@endtemplate}
class SignOut {
  /// {@macro sign_out}
  const SignOut({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  /// {@macro sign_out}
  Future<Either<Failure, None>> call() async {
    return await authenticationRepository.deleteTokens();
  }
}
