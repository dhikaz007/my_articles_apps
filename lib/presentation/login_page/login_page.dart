import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text.dart';
import '../../core/localizations/app_localizations.dart';
import '../../data/model/user_credential.dart';
import '../../logic/cubit/auth_cubit.dart';
import '../../logic/cubit/password_visibility_cubit.dart';
import '../../utils/utils.dart';
import 'widget/input_login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  static const String userNameData = 'rachman.latif@gmail.com';
  static const String passwordData = 'testing';

  static String userName = '';
  static String password = '';

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  AppText(
                    context: context,
                    text: '${AppLocalizations.of(context)?.titleApps}',
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
                    title: '${AppLocalizations.of(context)?.username}',
                    onChanged: (value) => userName = value,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
                    builder: (context, visibility) {
                      return InputLoginWidget(
                        title: '${AppLocalizations.of(context)?.password}',
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
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, auth) async {
                      if (auth is AuthLoading) {
                        const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.jadeJewel,
                          ),
                        );
                      } else if (auth is AuthAuthenticated) {
                        String? accessToken =
                            await TokenStoreges.getAccessToken();
                        if (accessToken != null) {
                          Future.delayed(
                            const Duration(seconds: 1),
                            () => Modular.to
                                .navigate('/home', arguments: userName),
                          ).then(
                            (_) => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: AppText(
                                  context: context,
                                  text: auth.message,
                                  style: AppTextStyle.title3,
                                  fontWeight: CustomFontWeight.medium,
                                  color: AppColors.primaryBlack,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          );
                        }
                      } else if (auth is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: AppText(
                              context: context,
                              text: auth.errorMessage,
                              style: AppTextStyle.title3,
                              fontWeight: CustomFontWeight.medium,
                              color: AppColors.primaryBlack,
                              maxLines: 2,
                            ),
                          ),
                        );
                      }
                    },
                    child: SizedBox(
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
                          if (formKey.currentState!.validate() &&
                              userName.contains(userNameData) &&
                              password.contains(passwordData)) {
                            UserCredential userCredential = UserCredential(
                              email: userName,
                              password: password,
                            );
                            ReadContext(context)
                                .read<AuthCubit>()
                                .loginEmailandPassword(
                                    userCredential: userCredential);
                          }
                        },
                        child: AppText(
                          context: context,
                          text:
                              '${AppLocalizations.of(context)?.login.toUpperCase()}',
                          style: AppTextStyle.title2,
                          fontWeight: CustomFontWeight.medium,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                    ),
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
