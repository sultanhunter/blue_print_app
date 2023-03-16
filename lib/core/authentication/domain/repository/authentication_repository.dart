import '../../data/firebase_auth_functions.dart';
import '../entities/authenticated__mobile_user.dart';

abstract class AuthenticationRepository
    extends FirebaseRepoAuthenticationFunctions {
  @override
  Future<void> sendCode({
    required String mobileNumber,
    required void Function(AuthenticatedMobileUser authenticatedUser)
        autoAuthenticated,
  });

  @override
  Future<AuthenticatedMobileUser> verifyCode({
    required String enteredCode,
  });
}
