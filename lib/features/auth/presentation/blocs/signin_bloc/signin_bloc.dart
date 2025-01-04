import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/auth/domain/repositories/auth_repository.dart';
import 'package:habit_quest/features/auth/domain/usecases/sign_in.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signin_bloc/signin_event.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signin_bloc/signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required SignIn signIn,
    required AuthRepository authRepository,
  })  : _signIn = signIn,
        _authRepository = authRepository,
        super(SignInInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
  }

  final SignIn _signIn;
  final AuthRepository _authRepository;

  // Handle the SignInRequested event
  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());

    try {
      await _signIn(event.signInModel);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(e.toString()));
    }
  }

  // Handle the GoogleSignInRequested event
  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());

    try {
      await _authRepository.signInViaGoogle();
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(e.toString()));
    }
  }
}
