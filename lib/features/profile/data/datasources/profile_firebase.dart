import 'package:firebase_auth/firebase_auth.dart';

class ProfileFirebase {
  ProfileFirebase({
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
