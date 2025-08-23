import 'package:get/get.dart';

import '../../repositories/repositories.dart';
import '../../view_models/view_models.dart';
import '../controllers.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(
        AuthViewModel(
          AuthRepository(),
        ),
      ),
    );
  }
}
