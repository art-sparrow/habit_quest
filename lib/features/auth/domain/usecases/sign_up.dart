import 'package:habit_quest/features/auth/data/models/signup_model.dart';
import 'package:habit_quest/features/auth/domain/repositories/auth_repository.dart';

class SignUp {
  SignUp({required this.repository});

  final AuthRepository repository;

  Future<void> call(SignUpModel signUpModel) async {
    await repository.signUp(signUpModel);
  }
}
