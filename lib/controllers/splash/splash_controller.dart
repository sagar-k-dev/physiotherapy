import 'package:get/get.dart';
import 'package:physiotherapy/utils/navigators/navigators.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startOnInit();
  }

  var isLoggedIn = false;

  void startOnInit() async {
    isLoggedIn = false;
    // var data = await HiveManager.getData(LocalKeys.userSigninData);
    // signInData = signInModelFromJson(data);
    await Future.delayed(const Duration(seconds: 3));

    if (isLoggedIn) {
      RouteManagement.goToHome();
    } else {
      RouteManagement.goToOnboarding();
    }
  }
}
