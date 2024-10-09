import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pawpal/core/data/repository/user_repo.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepo _userRepository;

  SignInBloc({required UserRepo userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    //sign in bloc method
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
      } catch (e) {
        log(e.toString());
        emit(const SignInFailure());
      }
    });

    //sign out bloc method
    on<SignOutRequired>((event, emit) async {
      try {
        await _userRepository.signOut();
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
