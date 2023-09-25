part of 'widgets.dart';

class ColorShimmer extends StatelessWidget {
  final double? w;
  final double? h;
  const ColorShimmer({
    super.key,
    this.w,
    this.h,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: AppColors.primaryGrey.withAlpha(50),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
