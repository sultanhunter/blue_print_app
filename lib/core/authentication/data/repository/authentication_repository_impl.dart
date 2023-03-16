import '../../domain/entities/authenticated__mobile_user.dart';
import '../../domain/repository/authentication_repository.dart';
import '../data_source/authentication_remote_client.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({required this.remoteClient});

  final AuthenticationRemoteClient remoteClient;
  @override
  Future<void> sendCode({
    required String mobileNumber,
    required void Function(AuthenticatedMobileUser authenticatedUser)
        autoAuthenticated,
  }) {
    return remoteClient.sendCode(
      mobileNumber: mobileNumber,
      autoAuthenticated: autoAuthenticated,
    );
  }

  @override
  Future<AuthenticatedMobileUser> verifyCode({
    required String enteredCode,
  }) async {
    final authenticatedMobileUser = await remoteClient.verifyCode(
      enteredCode: enteredCode,
    );
    return authenticatedMobileUser.toEntity();
  }

  @override
  Future<void> signOut() {
    return remoteClient.signOut();
  }
}
