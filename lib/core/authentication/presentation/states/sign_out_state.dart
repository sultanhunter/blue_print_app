import 'package:equatable/equatable.dart';

abstract class SignOutState extends Equatable {
  const SignOutState();

  @override
  List<Object?> get props => [];
}

class SignOutInitial extends SignOutState {}

class SignOutLoading extends SignOutState {}

class SignOutSuccess extends SignOutState {}

class SignOutError extends SignOutState {
  SignOutError({required this.errorMessage});

  final String errorMessage;
}
