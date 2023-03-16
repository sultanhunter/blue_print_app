import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

import 'authentication_states.dart';

class AuthenticationListenerService {
  AuthenticationListenerService() {
    startAuthenticationListener();
  }
  final authenticationState = Rx<AuthenticationState>(AuthenticationInitial());

  StreamSubscription<dynamic>? authListener;
  void startAuthenticationListener() {
    final auth = FirebaseAuth.instance;
    authListener = auth.authStateChanges().listen((event) {
      if (event != null) {
        authenticationState.value = AuthenticationAuthenticated(event);
      } else {
        authenticationState.value = AuthenticationUnauthenticated();
      }
    });
  }

  void dispose() {
    authListener?.cancel();
  }
}
