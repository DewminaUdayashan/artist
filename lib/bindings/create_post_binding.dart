import 'package:artist/controllers/create_post_controller.dart';
import 'package:get/get.dart';

class CreatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreatePostController());
  }
}
