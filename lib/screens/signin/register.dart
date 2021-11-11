import 'package:artist/api/api_provider.dart';
import 'package:artist/helpers/snack_helper.dart';
import 'package:artist/models/user_model.dart';
import 'package:artist/screens/signin/widgets/custom_text_field.dart';
import 'package:artist/shared/instances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name = '';
  String email = '';
  String pass = '';
  String rePass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 16.0,
            right: 16.0,
            left: 16.0,
          ),
          child: Column(
            children: [
              Lottie.asset(
                'assets/json/register.json',
                height: Get.height / 4,
              ),
              Text('Sign Up', style: context.textTheme.headline5),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'User Name',
                isPassword: true,
                prefixIcon: const Icon(Icons.person_outline),
                onChanged: (p0) {
                  name = p0;
                },
              ),
              CustomTextField(
                hintText: 'Email Address',
                isPassword: false,
                prefixIcon: const Icon(Icons.mail_outline),
                onChanged: (p0) {
                  email = p0;
                },
              ),
              CustomTextField(
                hintText: 'Password',
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline),
                onChanged: (p0) {
                  pass = p0;
                },
              ),
              CustomTextField(
                hintText: 'Re-Enter Password',
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline),
                onChanged: (p0) {
                  rePass = p0;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    if (name == '') {
                      SnackHelper.enterName();
                    } else if (!GetUtils.isEmail(email)) {
                      SnackHelper.enteEmail();
                    } else if (pass.length < 6) {
                      SnackHelper.passwordNotStrength();
                    } else if (pass != rePass) {
                      SnackHelper.passwordMismatch();
                    } else {
                      final user = UserModel(
                        name: name,
                        email: email,
                        password: pass,
                        mainPurpose: 0,
                      );
                      appController.currentUser.value = user;
                      Get.offNamed('/setup');
                    }
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      width: Get.width / 1.5,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
