import 'package:equatable/equatable.dart';

import '../../domain/entities/authenticated__mobile_user.dart';

abstract class VerifyCodeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyCodeInitial extends VerifyCodeState {}

class VerifyCodeLoading extends VerifyCodeState {}

class VerifyCodeSuccess extends VerifyCodeState {
  VerifyCodeSuccess(this.authenticatedMobileUser);

  final AuthenticatedMobileUser authenticatedMobileUser;
}

class VerifyCodeError extends VerifyCodeState {
  VerifyCodeError({required this.errorMessage});

  final String errorMessage;
}
