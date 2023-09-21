part of 'widgets.dart';

class InputLoginWidget extends StatelessWidget {
  final String title;
  final bool? obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  const InputLoginWidget({
    super.key,
    required this.title,
    this.obscureText,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.jadeJewel,
            fontWeight: FontWeight.normal,
          ),
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        label: AppText(
          context: context,
          text: title,
          style: AppTextStyle.title2,
          fontWeight: CustomFontWeight.medium,
          color: AppColors.jadeJewel,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.windSpeed,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
