part of 'widgets.dart';

class InputLoginWidget extends StatelessWidget {
  final String title;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  const InputLoginWidget({
    super.key,
    required this.title,
    this.obscureText,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withAlpha(30),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  context: context,
                  text: title,
                  style: AppTextStyle.font_12,
                  fontWeight: AppFontWeight.normal,
                  color: AppColors.primaryGreen,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.maxFinite,
                  height: 16,
                  child: TextField(
                    keyboardType: keyboardType,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.normal,
                    ),
                    obscureText: obscureText ?? false,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
          suffixIcon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
