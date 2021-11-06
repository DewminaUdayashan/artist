import 'package:artist/controllers/app_controller.dart';
import 'package:artist/controllers/user_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController(), permanent: true);
    Get.put(UserController(), permanent: true);
  }
}
