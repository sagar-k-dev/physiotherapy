part of 'app_pages.dart';

/// A chunks of routes and the path names which will be used to create
/// routes in [AppPages].
class Routes {
  static const String splash = _Paths.splash;
  static const String onboarding = _Paths.onboarding;
  static const String signIn = _Paths.signIn;
  static const String signUp = _Paths.signUp;
  static const String enterCode = _Paths.enterCode;
  static const String home = _Paths.home;
}

class _Paths {
  static const String splash = '/splashScreen';
  static const String onboarding = '/onboardingScreen';
  static const String signIn = '/signInScreen';
  static const String signUp = '/signUpScreen';
  static const String enterCode = '/enterCodeScreen';
  static const String home = '/homeScreen';
}
