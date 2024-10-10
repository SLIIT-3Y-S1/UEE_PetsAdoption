// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:pawpal/core/data/model/models.dart';
// import 'package:pawpal/core/data/repository/user_repo.dart';

// part 'sign_up_event.dart';
// part 'sign_up_state.dart';

// class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
//   final UserRepo _userRepository;

//   SignUpBloc({required UserRepo userRepository})
//       : _userRepository = userRepository,
//         super(SignUpInitial()) {
//     //signup event call
//     on<SignUpRequired>((event, emit) async {
//       try {
//         UserModel user =
//             await _userRepository.signUp(event.user, event.password);
//         await _userRepository.setUserData(user);
//         emit(SignUpSuccess());
//       } catch (e) {
//         emit(SignUpFailure());
//         log(e.toString());
//       }
//     });
//   }
// }
