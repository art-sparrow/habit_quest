import 'package:habit_quest/features/auth/data/models/reset_pwd_model.dart';
import 'package:habit_quest/features/auth/data/models/signin_model.dart';
import 'package:habit_quest/features/auth/data/models/signup_model.dart';
import 'package:habit_quest/features/auth/domain/entities/resetpwd_entity.dart';
import 'package:habit_quest/features/auth/domain/entities/signin_entity.dart';
import 'package:habit_quest/features/auth/domain/entities/signup_entity.dart';

// Extension to convert SignUpModel to SignUpEntity
extension SignUpModelToEntity on SignUpModel {
  SignUpEntity toEntity() {
    return SignUpEntity(
      name: name,
      phone: phone,
      email: email,
      password: password,
      joinedOn: joinedOn,
      uid: uid,
      fcmToken: fcmToken,
    );
  }
}

// Extension to convert SignUpEntity to SignUpModel
extension SignUpEntityToModel on SignUpEntity {
  SignUpModel toModel() {
    return SignUpModel(
      name: name,
      phone: phone,
      email: email,
      password: password,
      joinedOn: joinedOn,
      uid: uid,
      fcmToken: fcmToken,
    );
  }
}

// Extension to convert SignInModel to SignInEntity
extension SignInModelToEntity on SignInModel {
  SignInEntity toEntity() {
    return SignInEntity(
      email: email,
      password: password,
    );
  }
}

// Extension to convert SignInEntity to SignInModel
extension SignInEntityToModel on SignInEntity {
  SignInModel toModel() {
    return SignInModel(
      email: email,
      password: password,
    );
  }
}

// Extension to convert ResetPwdModel to ResetPwdEntity
extension ResetPwdModelToEntity on ResetPwdModel {
  ResetPwdEntity toEntity() {
    return ResetPwdEntity(
      email: email,
    );
  }
}

// Extension to convert ResetPwdEntity to ResetPwdModel
extension ResetPwdEntityToModel on ResetPwdEntity {
  ResetPwdModel toModel() {
    return ResetPwdModel(
      email: email,
    );
  }
}
