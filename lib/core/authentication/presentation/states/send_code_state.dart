import 'package:equatable/equatable.dart';

abstract class SendCodeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendCodeInitial extends SendCodeState {}

class SendCodeLoading extends SendCodeState {}

class SendCodeSuccess extends SendCodeState {}

class SendCodeError extends SendCodeState {
  SendCodeError({required this.errorMessage});

  final String errorMessage;
}
