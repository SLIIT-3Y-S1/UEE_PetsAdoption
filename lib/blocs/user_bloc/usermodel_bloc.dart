// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:pawpal/core/data/model/user_model.dart';
// import 'package:pawpal/core/data/repository/user_repo.dart';

// part 'usermodel_event.dart';
// part 'usermodel_state.dart';

// class UsermodelBloc extends Bloc<UsermodelEvent, UsermodelState> {

//   final UserRepo _userRepository;

//   UsermodelBloc({required UserRepo userRepository}) : _userRepository = userRepository, super (const UsermodelState.loading()) {
//     on<GetUserData>((event, emit) async {
//    try {
// 				UserModel userdata = await _userRepository.getUserData(event.userID);
//         emit(UsermodelState.success(userdata));
//       } catch (e) {
// 			log(e.toString());
// 			emit(const UsermodelState.failure());
//       }
//     });
//   }
// }
