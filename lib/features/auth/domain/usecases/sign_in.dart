import 'package:habit_quest/features/auth/data/models/signin_model.dart';
import 'package:habit_quest/features/auth/domain/repositories/auth_repository.dart';

class SignIn {
  SignIn({required this.repository});

  final AuthRepository repository;

  Future<void> call(SignInModel signInModel) async {
    await repository.signIn(signInModel);
  }
}
