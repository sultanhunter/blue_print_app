import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../domain/repository/authentication_repository.dart';
import 'states/send_code_state.dart';
import 'states/sign_out_state.dart';
import 'states/verify_code_state.dart';

class AuthenticationController {
  AuthenticationController({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;
  final loginFieldTextController = TextEditingController();
  final otpFieldTextController = TextEditingController();
  final sendCodeState = Rx<SendCodeState>(SendCodeInitial());
  final verifyCodeState = Rx<VerifyCodeState>(VerifyCodeInitial());
  final signOutState = Rx<SignOutState>(SignOutInitial());
  final agreeTerms = true.obs;

  void toggleAgreeTerms() {
    agreeTerms.value = !agreeTerms.value;
  }

  Future<void> signOut() async {
    signOutState.value = SignOutLoading();
    try {
      await _authenticationRepository.signOut();
      signOutState.value = SignOutSuccess();
    } catch (e) {
      signOutState.value = SignOutError(errorMessage: 'Failed to sign out');
    }
  }

  Future<void> verifyCode() async {
    verifyCodeState.value = VerifyCodeLoading();
    try {
      final authenticatedMobileUser =
          await _authenticationRepository.verifyCode(
        enteredCode: otpFieldTextController.text,
      );

      verifyCodeState.value = VerifyCodeSuccess(authenticatedMobileUser);
      print('success');
    } catch (e) {
      print(e.toString());
      verifyCodeState.value = VerifyCodeError(errorMessage: e.toString());
    }
  }

  Future<void> sendCode() async {
    sendCodeState.value = SendCodeLoading();
    final enteredPhoneNumber = int.tryParse(loginFieldTextController.text);
    if (enteredPhoneNumber == null) {
      sendCodeState.value =
          SendCodeError(errorMessage: 'Enter a valid phone number');
      return;
    } else {
      if (enteredPhoneNumber.toString().length != 10) {
        sendCodeState.value =
            SendCodeError(errorMessage: 'Enter a valid phone number');
        return;
      }
    }
    try {
      final phoneNumber = '+91${loginFieldTextController.text}';
      await _authenticationRepository.sendCode(
        mobileNumber: phoneNumber,
        autoAuthenticated: (authenticatedUser) {},
      );
      sendCodeState.value = SendCodeSuccess();
    } catch (e) {
      print(e.toString());
      sendCodeState.value = SendCodeError(errorMessage: e.toString());
    }
  }
}
