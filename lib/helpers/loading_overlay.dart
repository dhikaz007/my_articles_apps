part of 'helpers.dart';

class CustomLoadingOverlay {
  static void showLoadingOverlay(
    BuildContext context, {
    String msg = 'Loading, Please wait...',
  }) {
    if (!context.loaderOverlay.visible) {
      context.loaderOverlay.show();
    }
  }

  static void hideLoadingOverlay(BuildContext context) {
    if (context.loaderOverlay.visible) {
      context.loaderOverlay.hide();
    }
  }
}
