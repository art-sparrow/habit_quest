import 'package:equatable/equatable.dart';

class SignInEntity extends Equatable {
  const SignInEntity({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
