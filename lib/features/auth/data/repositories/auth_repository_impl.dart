import 'package:habit_quest/features/auth/data/datasources/auth_firebase.dart';
import 'package:habit_quest/features/auth/data/datasources/auth_objectbox.dart';
import 'package:habit_quest/features/auth/data/models/reset_pwd_model.dart';
import 'package:habit_quest/features/auth/data/models/signin_model.dart';
import 'package:habit_quest/features/auth/data/models/signup_model.dart';
import 'package:habit_quest/features/auth/domain/repositories/auth_repository.dart';
import 'package:habit_quest/shared/extensions/auth_extensions.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.authFirebase,
    required this.authObjectBox,
  });

  final AuthFirebase authFirebase;
  final AuthObjectBox authObjectBox;

  @override
  Future<void> signIn(SignInModel signInModel) async {
    // Convert SignInModel to SignInEntity using the extension
    final signInEntity = signInModel.toEntity();

    // Sign in with Firebase
    await authFirebase.signIn(signInEntity.email, signInEntity.password);

    // Fetch user data from Firebase
    final userModel = await authFirebase.getUserByEmail(signInEntity.email);

    if (userModel == null) {
      throw Exception('User not found in Firestore');
    }

    // Save user data locally in ObjectBox
    await authObjectBox.saveUserData(userModel);
  }

  @override
  Future<void> signInViaGoogle() async {
    // Perform Google Sign-In and get the user's email
    final email = await authFirebase.signInViaGoogle();
    if (email == null) {
      throw Exception('Sign-in canceled by user.');
    }

    // Fetch user data from Firestore
    final userModel = await authFirebase.getUserByEmail(email);
    if (userModel == null) {
      throw Exception('User not found in Firestore.');
    }

    // Save user data locally in ObjectBox
    await authObjectBox.saveUserData(userModel);
  }

  @override
  Future<void> signUp(SignUpModel signUpModel) async {
    // Convert SignUpMode to SignUpEntity using the extension
    final signUpEntity = signUpModel.toEntity();

    // Sign up user in Firebase
    final uid =
        await authFirebase.signUp(signUpEntity.email, signUpEntity.password);

    // Generate additional fields
    final completeModel = await authFirebase.completeSignUpModel(
      signUpModel.copyWith(uid: uid),
    );

    // Save user data to Firestore
    await authFirebase.saveUserData(completeModel);

    // Save user data locally in ObjectBox (excluding password)
    await authObjectBox.saveUserData(completeModel);
  }

  @override
  Future<void> resetPassword(ResetPwdModel resetPwdModel) async {
    // Convert ResetPwdModel to ResetPwdEntity using the extension
    final resetPwdEntity = resetPwdModel.toEntity();
    // Reset password
    await authFirebase.resetPassword(resetPwdEntity.email);
  }

  @override
  Future<SignUpModel?> getUserData(String uid, String email) async {
    final localData = await authObjectBox.getUserData(uid);
    return localData ?? await authFirebase.getUserByEmail(email);
  }

  @override
  Future<void> saveUserData(SignUpModel signUpModel) async {
    // Save data locally in ObjectBox
    await authObjectBox.saveUserData(signUpModel);
  }
}
