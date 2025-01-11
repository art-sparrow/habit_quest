import 'package:habit_quest/features/profile/data/datasources/profile_firebase.dart';
import 'package:habit_quest/features/profile/domain/repositories/profile_repository.dart';
import 'package:habit_quest/main_production.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required this.profileFirebase,
  });

  final ProfileFirebase profileFirebase;

  @override
  Future<void> signOut() async {
    await profileFirebase.signOut();

    // Clear progress
    objectbox.progressBox.removeAll();

    // Clear habits
    objectbox.habitBox.removeAll();

    // Clear user data
    objectbox.signUpBox.removeAll();
  }
}
