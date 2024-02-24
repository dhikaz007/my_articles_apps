part of 'screens.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Modular.to.pop(),
          child: Icon(
            Icons.arrow_back,
            color: AppColors.primaryBlack,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: AppText(
          context: context,
          text: '${AppLocalizations.of(context)?.selectLanguage}',
          style: AppTextStyle.font_20,
          fontWeight: AppFontWeight.bold,
          color: AppColors.primaryBlack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        children: [
          RadioListTile<bool>(
            title: AppText(
              context: context,
              text: 'Light',
              style: AppTextStyle.font_16,
              fontWeight: AppFontWeight.medium,
              color: AppColors.primaryBlack,
            ),
            value: true,
            groupValue:
                context.read<ThemeCubit>().state == ThemeState.lightTheme,
            onChanged: (value) {
              if (value == true) {
                context.read<ThemeCubit>().setDarkTheme(ThemeEvent.toogleDark);
                print(value);
              }
            },
          ),
          RadioListTile<bool>(
            title: AppText(
              context: context,
              text: 'Dark',
              style: AppTextStyle.font_16,
              fontWeight: AppFontWeight.medium,
              color: AppColors.primaryBlack,
            ),
            value: true,
            groupValue:
                context.read<ThemeCubit>().state == ThemeState.darkTheme,
            onChanged: (value) {
              if (value == true) {
                context.read<ThemeCubit>().setDarkTheme(ThemeEvent.toogleLight);
                print(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
