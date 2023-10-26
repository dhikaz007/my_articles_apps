part of 'screens.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({super.key});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: Column(
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  final dateFormated = DateFormat('y/M/d EEE')
                      .format(state.userResponse?.created ?? DateTime.now());
                  return Column(
                    children: [
                      TextField(
                        controller: TextEditingController(
                            text: state.userResponse?.uuid),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          label: AppText(
                            context: context,
                            text: 'User ID',
                            style: AppTextStyle.font_16,
                            fontWeight: AppFontWeight.medium,
                            color: AppColors.primaryGreen,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: TextEditingController(
                            text: state.userResponse?.name),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          label: AppText(
                            context: context,
                            text: 'Name',
                            style: AppTextStyle.font_16,
                            fontWeight: AppFontWeight.medium,
                            color: AppColors.primaryGreen,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: TextEditingController(
                            text: state.userResponse?.email),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          label: AppText(
                            context: context,
                            text: 'Email',
                            style: AppTextStyle.font_16,
                            fontWeight: AppFontWeight.medium,
                            color: AppColors.primaryGreen,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: TextEditingController(
                            text: state.userResponse?.phoneNumber),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          label: AppText(
                            context: context,
                            text: 'Phone Number',
                            style: AppTextStyle.font_16,
                            fontWeight: AppFontWeight.medium,
                            color: AppColors.primaryGreen,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: TextEditingController(text: dateFormated),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          label: AppText(
                            context: context,
                            text: 'Created',
                            style: AppTextStyle.font_16,
                            fontWeight: AppFontWeight.medium,
                            color: AppColors.primaryGreen,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        readOnly: true,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
