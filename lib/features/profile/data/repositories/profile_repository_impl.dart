import 'package:habit_quest/features/profile/data/datasources/profile_firebase.dart';
import 'package:habit_quest/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required this.profileFirebase,
  });

  final ProfileFirebase profileFirebase;

  @override
  Future<void> signOut() async {
    await profileFirebase.signOut();
  }
}
