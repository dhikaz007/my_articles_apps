part of 'screens.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Modular.to.pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  AppText(
                    context: context,
                    text: '${AppLocalizations.of(context)?.profile}',
                    style: AppTextStyle.font_20,
                    fontWeight: AppFontWeight.bold,
                    color: AppColors.primaryBlack,
                  ),
                  const Spacer(),
                  const IconButton(
                    onPressed: null,
                    icon: SizedBox(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                title: AppText(
                  context: context,
                  text: '${AppLocalizations.of(context)?.profile}',
                  style: AppTextStyle.font_16,
                  fontWeight: AppFontWeight.medium,
                  color: AppColors.primaryBlack,
                ),
                leading: const Icon(Icons.account_circle_outlined),
                trailing: IconButton(
                  onPressed: () => Modular.to.pushNamed('/profile-detail'),
                  icon: const Icon(Icons.keyboard_arrow_right),
                  iconSize: 28,
                ),
              ),
              ListTile(
                title: AppText(
                  context: context,
                  text: '${AppLocalizations.of(context)?.selectLanguage}',
                  style: AppTextStyle.font_16,
                  fontWeight: AppFontWeight.medium,
                  color: AppColors.primaryBlack,
                ),
                leading: SvgPicture.asset('assets/svg/globe.svg'),
                trailing: IconButton(
                  onPressed: () => Modular.to.pushNamed('/select-language'),
                  icon: const Icon(Icons.keyboard_arrow_right),
                  iconSize: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
