import 'package:equatable/equatable.dart';
import 'package:habit_quest/features/auth/data/models/signup_model.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequested extends SignUpEvent {
  const SignUpRequested(this.signUpModel);

  final SignUpModel signUpModel;

  @override
  List<Object> get props => [signUpModel];
}
