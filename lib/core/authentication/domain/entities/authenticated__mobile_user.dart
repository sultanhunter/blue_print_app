import 'package:equatable/equatable.dart';

class AuthenticatedMobileUser extends Equatable {
  const AuthenticatedMobileUser({
    required this.uuid,
    required this.mobile,
    required this.isNewUser,
  });
  final String uuid;
  final String mobile;
  final bool isNewUser;
  @override
  List<Object?> get props => [uuid];
}
