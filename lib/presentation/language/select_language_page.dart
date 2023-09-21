part of 'screens.dart';

class SelectLanguagePage extends StatelessWidget {
  const SelectLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Modular.to.pop(),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryBlack,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: AppText(
          context: context,
          text: '${AppLocalizations.of(context)?.selectLanguage}',
          style: AppTextStyle.title2,
          fontWeight: CustomFontWeight.bold,
          color: AppColors.primaryBlack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: language.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) => InkWell(
                  onTap: () => ReadContext(context)
                      .read<LanguageCubit>()
                      .setLanguage(Locale(
                        language[index].code,
                        language[index].countryCode,
                      )),
                  child: LanguageItem(
                    title: language[index].title,
                    lang: language[index].lang,
                    isSelected:
                        ReadContext(context).read<LanguageCubit>().locale ==
                            Locale(
                              language[index].code,
                              language[index].countryCode,
                            ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
