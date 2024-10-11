import 'package:bloc/bloc.dart';
import 'package:pawpal/core/services/auth_service.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_event.dart';
import 'package:pawpal/features/auth/bloc/user_bloc/user_auth_state.dart';
import 'package:pawpal/features/auth/user_auth/user_auth_services/user_firebase_services.dart';
import 'package:pawpal/models/user_model.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final AuthService _authService;
  final UserFirebaseServices _firestoreService;

  UserAuthBloc(this._authService, this._firestoreService)
      : super(UserAuthInitial()) {
    
    // Login request handler
    on<UserAuthLoginRequested>((event, emit) async {
      emit(UserAuthLoading());
      try {
        final user = await _authService.signInWithEmailAndPassword(
            event.email, event.password);

        if (user != null) {
          final UserModel? newUser =
              await _firestoreService.getUserData(event.email);
          if (newUser != null) {
            emit(UserAuthSuccess(newUser));
          } else {
            emit(UserAuthFailure('User data not found'));
          }
        } else {
          emit(UserAuthFailure('Invalid email or password'));
        }
      } catch (e) {
        emit(UserAuthFailure('Login failed: $e'));
      }
    });

    // Registration request handler
    on<UserAuthRegisterRequested>((event, emit) async {
      emit(UserRegisterLoading());
      try {
        final user = await _authService.signUpWithEmailAndPassword(
            event.email, event.password);

        if (user != null) {
          final UserModel newUser = UserModel(
            email: event.email,
            firstName: event.firstName,
            lastName: event.lastName,
            username: event.username,
          );

          final UserModel? savedUser =
              await _firestoreService.addUserToFirebase(newUser);

          if (savedUser != null) {
            emit(UserRegisterSuccess(savedUser));
          } else {
            emit(UserRegisterFailure('Failed to save user data'));
          }
        } else {
          emit(UserRegisterFailure('Failed to register user'));
        }
      } catch (e) {
        emit(UserRegisterFailure('Registration failed: $e'));
      }
    });
  }
}
