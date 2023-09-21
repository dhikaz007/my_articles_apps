part of 'widgets.dart';

class RectangleShimmer extends StatelessWidget {
  final double h;
  final double w;
  const RectangleShimmer({
    super.key,
    this.w = 250,
    this.h = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(.3),
      highlightColor: Colors.grey.withOpacity(.2),
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.8),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
