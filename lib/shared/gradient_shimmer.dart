part of 'widgets.dart';

enum ShimmerType { inner, outer }

class GradientShimmer extends StatelessWidget {
  final double? h;
  final double? w;
  const GradientShimmer({
    super.key,
    this.w,
    this.h,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: AppColors.primaryShimmerColor,
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: AppColors.primaryGrey,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
