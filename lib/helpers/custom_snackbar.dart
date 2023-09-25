part of 'helpers.dart';

enum SnackBarStatus { warning, success, failure }

class CustomSnackbar {
  static void showSnackbar(
    BuildContext context,
    String message,
    SnackBarStatus? type, {
    bool dismissable = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: type == SnackBarStatus.success
            ? Colors.green.withOpacity(.9)
            : type == SnackBarStatus.failure
                ? Colors.red.withOpacity(.9)
                : type == SnackBarStatus.warning
                    ? Colors.yellowAccent.withOpacity(.9)
                    : null,
        action: dismissable
            ? SnackBarAction(
                label: 'Dismiss',
                onPressed: () => Modular.to.pop(),
                textColor: type == null
                    ? AppColors.primaryBlack
                    : AppColors.primaryWhite,
              )
            : null,
        margin: const EdgeInsets.only(
          bottom: 20,
          right: 20,
          left: 20,
        ),
        dismissDirection: DismissDirection.none,
        content: AppText(
          context: context,
          text: message,
          style: AppTextStyle.font_16,
          fontWeight: AppFontWeight.normal,
          color: AppColors.primaryWhite,
          maxLines: 2,
        ),
      ),
    );
  }
}
