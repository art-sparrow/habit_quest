import 'package:equatable/equatable.dart';
import 'package:habit_quest/features/auth/data/models/signin_model.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends SignInEvent {
  const SignInRequested(this.signInModel);

  final SignInModel signInModel;

  @override
  List<Object> get props => [signInModel];
}
