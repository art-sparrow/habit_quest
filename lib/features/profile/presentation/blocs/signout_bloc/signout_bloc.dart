import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/profile/domain/repositories/profile_repository.dart';
import 'package:habit_quest/features/profile/presentation/blocs/signout_bloc/signout_event.dart';
import 'package:habit_quest/features/profile/presentation/blocs/signout_bloc/signout_state.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  SignOutBloc({required this.profileRepository}) : super(SignOutInitial()) {
    on<SignOutRequested>(_onSignOutRequested);
  }

  final ProfileRepository profileRepository;

  // Handle the SignOutRequested event
  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<SignOutState> emit,
  ) async {
    // Emit loading state
    emit(SignOutLoading());

    try {
      // Call the sign-out use case
      await profileRepository.signOut();

      // Emit success state
      emit(SignOutSuccess());
    } catch (e) {
      // Emit failure state with error message
      emit(SignOutFailure(e.toString()));
    }
  }
}
