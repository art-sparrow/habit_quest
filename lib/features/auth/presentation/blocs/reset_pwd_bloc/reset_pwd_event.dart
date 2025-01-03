import 'package:equatable/equatable.dart';
import 'package:habit_quest/features/auth/data/models/reset_pwd_model.dart';

abstract class ResetPwdEvent extends Equatable {
  const ResetPwdEvent();

  @override
  List<Object> get props => [];
}

class ResetPwdRequested extends ResetPwdEvent {
  const ResetPwdRequested(this.resetPwdModel);

  final ResetPwdModel resetPwdModel;

  @override
  List<Object> get props => [resetPwdModel];
}
