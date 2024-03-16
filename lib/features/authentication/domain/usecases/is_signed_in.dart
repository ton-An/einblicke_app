import 'package:dartz/dartz.dart';
import 'package:einblicke_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:einblicke_shared/einblicke_shared.dart';

/// {@template is_signed_in}
/// __Is Signed In__ checks if the user is signed in.
///
/// Returns:
/// - [bool]: true if the user is signed in, false otherwise.
///
/// Failures:
/// - [SecureStorageReadFailure]
/// {@endtemplate}
class IsSingnedIn {
  /// {@macro is_signed_in}
  const IsSingnedIn({required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  /// {@macro is_signed_in}
  Future<Either<Failure, bool>> call() async {
    return await authenticationRepository.isTokenBundlePresent();
  }
}
