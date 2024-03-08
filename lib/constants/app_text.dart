part of 'constants.dart';

enum AppTextStyle {
  none,
  font_40,
  font_20,
  font_16,
  font_12;
}

enum AppFontWeight {
  normal,
  medium,
  bold;

  FontWeight get value => switch (this) {
        normal => FontWeight.w400,
        medium => FontWeight.w500,
        bold => FontWeight.w700,
      };
}

class AppText extends StatelessWidget {
  final String text;
  final BuildContext context;
  final AppTextStyle style;
  final AppFontWeight fontWeight;
  final TextAlign? textAlign;
  final Color color;
  final int? maxLines;
  final TextOverflow? overflow;
  const AppText({
    super.key,
    required this.context,
    required this.text,
    required this.style,
    required this.fontWeight,
    this.textAlign,
    required this.color,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? getAppTextStyle() {
      switch (style) {
        case AppTextStyle.none:
          return Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
              );
        case AppTextStyle.font_40:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 40,
          );
        case AppTextStyle.font_20:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 20,
          );
        case AppTextStyle.font_16:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 16,
          );
        case AppTextStyle.font_12:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 12,
          );
      }
    }

    return Text(
      text,
      style: getAppTextStyle(),
      textAlign: textAlign,
      maxLines: maxLines ?? 1,
      overflow: overflow,
    );
  }
}
