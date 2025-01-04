import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/auth/domain/usecases/reset_pwd.dart';
import 'package:habit_quest/features/auth/presentation/blocs/reset_pwd_bloc/reset_pwd_event.dart';
import 'package:habit_quest/features/auth/presentation/blocs/reset_pwd_bloc/reset_pwd_state.dart';

class ResetPwdBloc extends Bloc<ResetPwdEvent, ResetPwdState> {
  ResetPwdBloc({required ResetPassword resetPassword})
      : _resetPassword = resetPassword,
        super(ResetPwdInitial()) {
    on<ResetPwdRequested>(_onResetPwdRequested);
  }

  final ResetPassword _resetPassword;

  // Handle the SignInRequested event
  Future<void> _onResetPwdRequested(
    ResetPwdRequested event,
    Emitter<ResetPwdState> emit,
  ) async {
    // Emit loading state
    emit(ResetPwdLoading());

    try {
      // Call the sign-up use case
      await _resetPassword(event.resetPwdModel);

      // Emit success state
      emit(ResetPwdSuccess());
    } catch (e) {
      // Emit failure state with error message
      emit(ResetPwdFailure(e.toString()));
    }
  }
}
