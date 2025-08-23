import 'package:get/get.dart';

import 'app_pages.dart';

abstract class RouteManagement {
  /// Go to the SignIn Screen
  static void goToSignIn() {
    Get.offAllNamed<void>(Routes.signIn);
  }

  static void goToOnboarding() {
    Get.offAllNamed<void>(Routes.onboarding);
  }

  /// Go to the Home Screen
  static void goToHome() {
    Get.offAllNamed<void>(Routes.home);
  }

  /// Go to the SignUp Screen
  static void goToSignUp() {
    Get.toNamed<void>(Routes.signUp);
  }

  /// Go to the Enter Code Screen
  static void goToEnterCode() {
    Get.toNamed<void>(Routes.enterCode);
  }
}
