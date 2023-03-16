import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../firebase_auth_functions.dart';
import '../model/authenticated_mobile_user_model.dart';

abstract class AuthenticationRemoteClient
    extends FirebaseAuthenticationFunctions {
  @override
  Future<void> sendCode({
    required String mobileNumber,
    required void Function(AuthenticatedMobileUserModel authenticatedUser)
        autoAuthenticated,
  });

  @override
  Future<AuthenticatedMobileUserModel> verifyCode({
    required String enteredCode,
  });
}

class FirebaseAuthClientImpl implements AuthenticationRemoteClient {
  FirebaseAuthClientImpl();

  String? _verificationId;
  int? _resendToken;

  @override
  Future<void> sendCode({
    required String mobileNumber,
    required void Function(AuthenticatedMobileUserModel) autoAuthenticated,
  }) async {
    final auth = FirebaseAuth.instance;
    final completer = Completer<void>();
    await auth.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      forceResendingToken: _resendToken,
      verificationCompleted: (phoneAuthCredential) async {
        try {
          final user = await auth.signInWithCredential(phoneAuthCredential);
          final uuid = user.user?.uid;
          final mobile = user.user?.phoneNumber;
          if (uuid != null && mobile != null) {
            final db = FirebaseFirestore.instance;
            final userCollection = db.collection('users');
            final doc = await userCollection.doc(uuid).get();
            final bool isNewUser;
            if (doc.exists) {
              isNewUser = false;
            } else {
              isNewUser = true;
            }
            final authenticatedUserModel = AuthenticatedMobileUserModel(
              mobile: mobile,
              uuid: uuid,
              isNewUser: isNewUser,
            );
            autoAuthenticated(authenticatedUserModel);
            if (!completer.isCompleted) {
              completer.complete();
            }
          }
        } catch (e) {
          if (!completer.isCompleted) {
            completer.completeError(e);
          }
        }
      },
      verificationFailed: (error) {
        if (!completer.isCompleted) {
          completer.completeError(error.message ?? '');
        }
      },
      codeSent: (verificationId, resendToken) {
        _verificationId = verificationId;
        _resendToken = resendToken;
        if (!completer.isCompleted) {
          completer.complete();
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
    return completer.future;
  }

  @override
  Future<AuthenticatedMobileUserModel> verifyCode({
    required String enteredCode,
  }) async {
    try {
      final phoneCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId ?? '',
        smsCode: enteredCode,
      );
      final auth = FirebaseAuth.instance;

      final user = await auth.signInWithCredential(phoneCredential);
      final uuid = user.user?.uid;
      final mobile = user.user?.phoneNumber;
      if (uuid != null && mobile != null) {
        final db = FirebaseFirestore.instance;
        final userCollection = db.collection('users');
        final doc = await userCollection.doc(uuid).get();
        final bool isNewUser;
        if (doc.exists) {
          isNewUser = false;
        } else {
          isNewUser = true;
        }
        final authenticatedUserModel = AuthenticatedMobileUserModel(
          mobile: mobile,
          uuid: uuid,
          isNewUser: isNewUser,
        );
        return authenticatedUserModel;
      } else {
        throw Exception('Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() {
    try {
      final auth = FirebaseAuth.instance;
      return auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
