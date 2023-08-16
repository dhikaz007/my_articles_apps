import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';
import '../../logic/cubit/auth_cubit.dart';
import '../../logic/cubit/password_visibility_cubit.dart';
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
          create: (context) => AuthCubit(
            authRepositoryImpl: AuthRepositoryImpl(),
          ),
        ),
      ],
      child: const LoginPage(),
    );
  }
}
