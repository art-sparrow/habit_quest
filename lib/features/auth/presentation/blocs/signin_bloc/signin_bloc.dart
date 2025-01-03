import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/auth/domain/usecases/sign_in.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signin_bloc/signin_event.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signin_bloc/signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required SignIn signIn})
      : _signIn = signIn,
        super(SignInInitial()) {
    on<SignInRequested>(_onSignInRequested);
  }

  final SignIn _signIn;

  // Handle the SignInRequested event
  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<SignInState> emit,
  ) async {
    // Emit loading state
    emit(SignInLoading());

    try {
      // Call the sign-up use case
      await _signIn(event.signInModel);

      // Emit success state
      emit(SignInSuccess());
    } catch (e) {
      // Emit failure state with error message
      emit(SignInFailure(e.toString()));
    }
  }
}
