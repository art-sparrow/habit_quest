import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/auth/domain/usecases/sign_up.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signup_bloc/signup_event.dart';
import 'package:habit_quest/features/auth/presentation/blocs/signup_bloc/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required SignUp signUp})
      : _signUp = signUp,
        super(SignUpInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
  }

  final SignUp _signUp;

  // Handle the SignUpRequested event
  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<SignUpState> emit,
  ) async {
    // Emit loading state
    emit(SignUpLoading());

    try {
      // Call the sign-up use case
      await _signUp(event.signUpModel);

      // Emit success state
      emit(SignUpSuccess());
    } catch (e) {
      // Emit failure state with error message
      emit(SignUpFailure(e.toString()));
    }
  }
}
