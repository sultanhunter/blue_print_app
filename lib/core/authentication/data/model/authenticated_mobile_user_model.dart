import '../../domain/entities/authenticated__mobile_user.dart';

class AuthenticatedMobileUserModel extends AuthenticatedMobileUser {
  const AuthenticatedMobileUserModel({
    required super.uuid,
    required super.mobile,
    required super.isNewUser,
  });

  factory AuthenticatedMobileUserModel.fromJson(Map<String, dynamic> json) {
    return AuthenticatedMobileUserModel(
      uuid: json['uuid'] as String,
      mobile: json['mobile'] as String,
      isNewUser: json['isNewUser'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'mobile': mobile,
      'isNewUser': isNewUser,
    };
  }

  AuthenticatedMobileUser toEntity() {
    return AuthenticatedMobileUser(
      uuid: uuid,
      mobile: mobile,
      isNewUser: isNewUser,
    );
  }
}
