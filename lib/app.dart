import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawpal/app_view.dart';
import 'package:pawpal/blocs/auth_bloc/authentication_bloc.dart';
import 'package:pawpal/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:pawpal/core/data/repository/user_repo.dart';
import 'package:pawpal/features/authentication/screens/signup_screen.dart';
import 'package:pawpal/features/common/homescreen.dart';
import 'package:pawpal/theme/theme.dart';

class MainApp extends StatelessWidget {
	final UserRepo userRepository;
  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
			providers: [
				RepositoryProvider<AuthenticationBloc>(
					create: (_) => AuthenticationBloc(
						myUserRepository: userRepository
					)
				)
			], 
			child: const MyAppView()
		);
  }
}

