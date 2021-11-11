import 'package:artist/helpers/snack_helper.dart';
import 'package:artist/helpers/storage_helper.dart';
import 'package:artist/models/user_model.dart';
import 'package:artist/shared/instances.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';

const baseUrl = 'http://192.168.34.2:5000';
const _login = '$baseUrl/users/signin';
const _register = '$baseUrl/users/signup';
const _verified = '$baseUrl/users/check_account_verification';

class ApiProvider extends GetConnect {
  Future<void> login() async {
    print(appController.loginEmail);
    final response = await post(_login, {
      'email': appController.loginEmail,
      'password': appController.loginPw,
    });
    print(response.body);
    print(response.statusCode);
    if (response.status.isOk) {
      if (!response.body['error']) {
        appController.currentUser.value =
            UserModel.fromMap(response.body['user']);
        appController.sessionToken = response.body['token'];
        if (!appController.currentUser.value.isVerified!) {
          Get.toNamed('/verification');
        } else {
          Get.offAllNamed('/home');
        }
      } else {
        SnackHelper.loginError(response.body['message']);
      }
    }
  }

  Future<void> registerUser(UserModel user) async {
    print('register');
    final response = await post(_register, user.toJson());
    print(response.statusCode);
    print(response);
    print(response.body);
    if (response.status.isOk) {
      if (!response.body['error']) {
        appController.sessionToken = response.body['token'];
        Get.toNamed('/verification');
      } else {
        SnackHelper.somethingWentWrong(response.body['message']);
      }
    }
  }

  Future<void> isVerified() async {
    final response = await get(_verified,
        headers: {'authorization': appController.sessionToken});
    if (response.status.isOk) {
      print(appController.sessionToken);
      print(response.body);
      if (!response.body['error']) {}
    }
  }
}
