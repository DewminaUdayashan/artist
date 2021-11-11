import 'package:artist/api/api_provider.dart';
import 'package:artist/controllers/app_controller.dart';
import 'package:artist/models/user_model.dart';
import 'package:artist/screens/signin/widgets/custom_text_field.dart';
import 'package:artist/shared/instances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

// CONSTANTS
import 'package:artist/shared/text.dart';

class Signin extends GetWidget<AppController> {
  const Signin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Lottie.asset('assets/json/data.json', width: 300),
                // Image.asset('assets/images/11.gif'),
                Text(
                  title,
                  style: GoogleFonts.fredokaOne(
                    color: Colors.black87,
                    letterSpacing: .5,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  descriptionLine01,
                  style: GoogleFonts.aBeeZee(
                    color: Colors.black54,
                    letterSpacing: .5,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  descriptionLine02,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balsamiqSans(
                    color: Colors.black54,
                    letterSpacing: .5,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: const [
                    CustomTextField(
                      hintText: 'Email Address',
                      isPassword: false,
                      prefixIcon: Icon(Icons.mail_outline),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      isPassword: true,
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      ApiProvider().login();
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
                            'Log in',
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
                // Row(
                //   children: const [
                //     Expanded(child: Divider()),
                //     Padding(
                //       padding: EdgeInsets.all(8.0),
                //       child: Text('OR'),
                //     ),
                //     Expanded(child: Divider()),
                //   ],
                // ),
                // Material(
                //   color: Colors.transparent,
                //   child: InkWell(
                //     borderRadius: BorderRadius.circular(30),
                //     onTap: () {
                //       controller.signIn();
                //     },
                //     child: Ink(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //       child: Container(
                //         width: Get.width / 1.5,
                //         padding: const EdgeInsets.all(15),
                //         decoration: BoxDecoration(
                //           // color: Colors.black12,
                //           borderRadius:
                //               const BorderRadius.all(Radius.circular(10)),
                //           border: Border.all(color: Colors.black12),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Image.asset(
                //               'assets/images/icons/google.png',
                //               height: 20,
                //             ),
                //             const SizedBox(width: 15),
                //             const Text(
                //               'Continue with Google',
                //               style: TextStyle(
                //                 fontSize: 16,
                //                 color: Colors.black54,
                //                 fontWeight: FontWeight.w500,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed('/register'),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.montserrat(
                          color: Colors.blueAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ubuntu
// monsrat