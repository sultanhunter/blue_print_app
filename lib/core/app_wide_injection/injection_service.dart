import 'package:get_it/get_it.dart';

import '../authentication/data/data_source/authentication_remote_client.dart';
import '../authentication/data/repository/authentication_repository_impl.dart';
import '../authentication/presentation/authentication_controller.dart';
import '../authentication_listener/authentication_listener_service.dart';

void initializeAppWideInjection() {
  final getIt = GetIt.instance;
  _instancesToInject.forEach((instance) {
    getIt.registerLazySingleton(instance);
  });
}

final _instancesToInject = <dynamic>[
  AuthenticationListenerService(),
  AuthenticationController(
      authenticationRepository:
          AuthenticationRepositoryImpl(remoteClient: FirebaseAuthClientImpl()))
];
