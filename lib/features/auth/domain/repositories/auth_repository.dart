// ignore_for_file: lines_longer_than_80_chars

import 'package:habit_quest/features/auth/data/models/reset_pwd_model.dart';
import 'package:habit_quest/features/auth/data/models/signin_model.dart';
import 'package:habit_quest/features/auth/data/models/signup_model.dart';

abstract class AuthRepository {
  Future<void> signIn(SignInModel signInModel);
  Future<void> signInViaGoogle();
  Future<void> signUp(SignUpModel signUpModel);
  Future<void> resetPassword(ResetPwdModel resetPwdModel);
  // Retrieve user data (ObjectBox or Firebase)
  Future<SignUpModel?> getUserData(
    String uid,
    String email,
  );
  // Save user data (ObjectBox)
  Future<void> saveUserData(
    SignUpModel signUpModel,
  );
}
