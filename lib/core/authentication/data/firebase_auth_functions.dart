import '../domain/entities/authenticated__mobile_user.dart';
import 'model/authenticated_mobile_user_model.dart';

abstract class FirebaseAuthenticationFunctions {
  Future<void> sendCode({
    required String mobileNumber,
    required void Function(AuthenticatedMobileUserModel authenticatedUser)
        autoAuthenticated,
  });

  Future<AuthenticatedMobileUserModel> verifyCode({
    required String enteredCode,
  });

  Future<void> signOut();
}

abstract class FirebaseRepoAuthenticationFunctions {
  Future<void> sendCode({
    required String mobileNumber,
    required void Function(AuthenticatedMobileUser authenticatedUser)
        autoAuthenticated,
  });

  Future<AuthenticatedMobileUser> verifyCode({
    required String enteredCode,
  });

  Future<void> signOut();
}
