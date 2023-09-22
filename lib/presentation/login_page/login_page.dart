// ignore_for_file: use_build_context_synchronously

part of 'screens.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  // static const String userNameData = 'rachman.latif@gmail.com';
  // static const String passwordData = 'testing';

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
                  SizedBox(
                    width: widthSize,
                    child: BlocListener<AuthCubit, AuthState>(
                      listener: (context, auth) async {
                        debugPrint('AUTH STATE $auth');
                        if (auth is AuthLoading) {
                          CustomLoadingOverlay.showLoadingOverlay(context);
                        }
                        if (auth is AuthError) {
                          CustomLoadingOverlay.hideLoadingOverlay(context);
                          CustomSnackbar.showSnackbar(
                            context,
                            auth.errorMessage,
                            SnackBarStatus.failure,
                          );
                        }
                        if (auth is AuthAuthenticated) {
                          String? accessToken =
                              await TokenStoreges.getAccessToken();
                          if (accessToken == null || accessToken.isEmpty) {
                            debugPrint('TOKEN GAK ADA $accessToken');
                            Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                Modular.to.navigate('/login');
                              },
                            );
                          } else {
                            debugPrint('TOKEN ADA $accessToken');

                            Modular.to.navigate('/home', arguments: userName);
                          }
                          CustomLoadingOverlay.hideLoadingOverlay(context);
                          CustomSnackbar.showSnackbar(
                            context,
                            auth.message,
                            SnackBarStatus.success,
                          );
                        }
                      },
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
                          if (formKey.currentState!.validate()) {
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
