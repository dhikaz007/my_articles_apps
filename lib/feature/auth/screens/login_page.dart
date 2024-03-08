// ignore_for_file: use_build_context_synchronously

part of 'screens.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // static const String userNameData = 'rachman.latif@gmail.com';
  // static const String passwordData = 'testing';

  static String userName = '';
  static String password = '';

  void errorDialog({required BuildContext context, required String message}) {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(
          const Duration(seconds: 2),
          () => Modular.to.pop(),
        );
        return Center(
          child: Container(
            width: 300,
            height: 40,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                SvgPicture.asset('assets/svg/error.svg'),
                const SizedBox(width: 8),
                AppText(
                  context: context,
                  text: message,
                  style: AppTextStyle.font_12,
                  fontWeight: AppFontWeight.normal,
                  color: AppColors.primaryWhite,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void loadingOverlay(BuildContext context, UserResponse? userResponse) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOut,
          builder: (context, value, child) =>
              CircularProgressIndicator.adaptive(
            backgroundColor: AppColors.primaryBlack,
            value: value,
            valueColor: AlwaysStoppedAnimation(AppColors.secondayBlue),
          ),
          onEnd: () {
            Modular.to.navigate('/home', arguments: userResponse);
          },
        ),
      ),
    );
  }

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
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                AppText(
                  context: context,
                  text: '${AppLocalizations.of(context)?.titleApps}',
                  style: AppTextStyle.font_40,
                  fontWeight: AppFontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
                Image.asset(
                  'assets/png/logo.png',
                  width: widthSize,
                  height: 384,
                ),
                InputLoginWidget(
                  title: '${AppLocalizations.of(context)?.username}',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => userName = value,
                ),
                const SizedBox(height: 12),
                InputLoginWidget(
                  title: '${AppLocalizations.of(context)?.password}',
                  keyboardType: TextInputType.text,
                  //obscureText: !visibility.isVisible,
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.visibility,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  onChanged: (value) => password = value,
                ),
                const SizedBox(height: 44),
                SizedBox(
                  width: widthSize,
                  child: BlocListener<AuthCubit, AuthState>(
                    listener: (context, auth) async {
                      debugPrint('AUTH STATE $auth');
                      if (auth is AuthLoading) {
                        //CustomLoadingOverlay.showLoadingOverlay(context);
                      }
                      if (auth is AuthError) {
                        //CustomLoadingOverlay.hideLoadingOverlay(context);
                        CustomSnackbar.showSnackbar(
                          context,
                          auth.errorMessage,
                          SnackBarStatus.failure,
                        );

                        if (userName.isEmpty) {
                          errorDialog(
                            context: context,
                            message: 'Username can\'t Empty',
                          );
                        } else if (password.isEmpty) {
                          errorDialog(
                            context: context,
                            message: 'Password can\'t Empty',
                          );
                        }
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
                          loadingOverlay(context, auth.userResponse);
                          //Modular.to.navigate('/home', arguments: userName);
                        }
                        // CustomLoadingOverlay.hideLoadingOverlay(context);
                        // CustomSnackbar.showSnackbar(
                        //   context,
                        //   auth.message,
                        //   SnackBarStatus.success,
                        // );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryBlack.withAlpha(25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          fixedSize: const MaterialStatePropertyAll(
                            Size(double.maxFinite, 56),
                          ),
                          backgroundColor: MaterialStatePropertyAll(
                            AppColors.primaryGreen,
                          ),
                        ),
                        onPressed: () {
                          UserCredential userCredential = UserCredential(
                            email: userName,
                            password: password,
                          );
                          context
                              .read<AuthCubit>()
                              .login(userCredential: userCredential);
                        },
                        child: AppText(
                          context: context,
                          text:
                              '${AppLocalizations.of(context)?.login.toUpperCase()}',
                          style: AppTextStyle.font_16,
                          fontWeight: AppFontWeight.medium,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
