import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:habit_quest/features/auth/data/models/signup_model.dart';
import 'package:intl/intl.dart';

class AuthFirebase {
  AuthFirebase({
    required this.firebaseAuth,
    required this.firestore,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  Future<void> signIn(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<String> signUp(String email, String password) async {
    final user = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user!.uid;
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<SignUpModel?> getUserByEmail(String email) async {
    final snapshot = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;

    final data = snapshot.docs.first.data();
    return SignUpModel.fromJson(data);
  }

  Future<SignUpModel> completeSignUpModel(SignUpModel model) async {
    final fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    final joinedOn = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return model.copyWith(
      fcmToken: fcmToken,
      joinedOn: joinedOn,
      password: '',
    );
  }

  Future<void> saveUserData(SignUpModel model) async {
    await firestore.collection('users').doc(model.uid).set(model.toJson());
  }
}
