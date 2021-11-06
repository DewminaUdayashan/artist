import 'package:artist/controllers/edit_account_controller.dart';
import 'package:get/get.dart';

class EditAccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(EditAccountController());
  }
}
