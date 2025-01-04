import 'package:habit_quest/features/auth/data/models/reset_pwd_model.dart';
import 'package:habit_quest/features/auth/domain/repositories/auth_repository.dart';

class ResetPassword {
  ResetPassword({required this.repository});

  final AuthRepository repository;

  Future<void> call(ResetPwdModel resetPwdModel) async {
    await repository.resetPassword(resetPwdModel);
  }
}
