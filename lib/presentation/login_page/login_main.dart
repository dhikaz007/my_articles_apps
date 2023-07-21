import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';
import '../../logic/bloc/auth_bloc.dart';
import '../../logic/cubit/passwordv_visibility_cubit.dart';
import 'login_page.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PasswordVisibilityCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authRepositoryImpl: AuthRepositoryImpl(),
          ),
        ),
      ],
      child: const LoginPage(),
    );
  }
}
