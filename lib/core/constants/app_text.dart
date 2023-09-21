part of 'constants.dart';

enum AppTextStyle {
  none,
  display1,
  headline1,
  headline2,
  title1,
  title2,
  title3,
  body1,
  body2,
  body3;
}

enum CustomFontWeight {
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
  final CustomFontWeight fontWeight;
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
        case AppTextStyle.display1:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 36,
          );
        case AppTextStyle.headline1:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 28,
          );
        case AppTextStyle.headline2:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 24,
          );
        case AppTextStyle.title1:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 20,
          );
        case AppTextStyle.title2:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 18,
          );
        case AppTextStyle.title3:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 16,
          );
        case AppTextStyle.body1:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 14,
          );
        case AppTextStyle.body2:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 12,
          );
        case AppTextStyle.body3:
          return TextStyle(
            color: color,
            fontWeight: fontWeight.value,
            fontSize: 10,
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
