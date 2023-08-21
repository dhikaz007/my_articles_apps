import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text.dart';
import '../../logic/cubit/auth_cubit.dart';
import '../../logic/cubit/password_visibility_cubit.dart';
import 'widget/input_login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String userNameData = 'rachman.latif@gmail.com';
  static const String passwordData = 'testing';

  static String userName = '';
  static String password = '';

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: AppText(
                  context: context,
                  text: state.errorMessage,
                  style: AppTextStyle.title1,
                  fontWeight: CustomFontWeight.medium,
                  color: AppColors.primaryBlack,
                ),
              ),
            );
          } else if (state is AuthAuthenticated) {
            Modular.to.navigate('/home',arguments: userName);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  AppText(
                    context: context,
                    text: 'My Article Apps',
                    style: AppTextStyle.display1,
                    fontWeight: CustomFontWeight.bold,
                    color: AppColors.jadeJewel,
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/png/logo.png',
                    width: widthSize,
                    height: 300,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 20),
                  InputLoginWidget(
                    title: 'Username',
                    onChanged: (value) => userName = value,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
                    builder: (context, visibility) {
                      return InputLoginWidget(
                        title: 'Password',
                        obscureText: !visibility.isVisible,
                        suffixIcon: IconButton(
                          onPressed: () => ReadContext(context)
                              .read<PasswordVisibilityCubit>()
                              .toggleVisibility(
                                  isVisible: !visibility.isVisible),
                          icon: Icon(
                            !visibility.isVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 24,
                            color: AppColors.jadeJewel,
                          ),
                        ),
                        onChanged: (value) => password = value,
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, auth) {
                      if (auth is AuthLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.jadeJewel,
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: widthSize,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              padding: const MaterialStatePropertyAll(
                                EdgeInsets.all(20),
                              ),
                              backgroundColor: const MaterialStatePropertyAll(
                                AppColors.jadeJewel,
                              ),
                            ),
                            onPressed: () {
                              if (userName.contains(userNameData) &&
                                  password.contains(passwordData)) {
                                ReadContext(context)
                                    .read<AuthCubit>()
                                    .loginState(
                                      userName: userName,
                                      password: password,
                                    );
                              } else {
                                if (userName.isEmpty || password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: AppText(
                                        context: context,
                                        text: 'Field must not empty',
                                        style: AppTextStyle.title3,
                                        fontWeight: CustomFontWeight.medium,
                                        color: AppColors.primaryWhite,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: AppText(
                                        context: context,
                                        text: 'Username or password not found',
                                        style: AppTextStyle.title3,
                                        fontWeight: CustomFontWeight.medium,
                                        color: AppColors.primaryWhite,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: AppText(
                              context: context,
                              text: 'LOGIN',
                              style: AppTextStyle.title2,
                              fontWeight: CustomFontWeight.medium,
                              color: AppColors.primaryWhite,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
