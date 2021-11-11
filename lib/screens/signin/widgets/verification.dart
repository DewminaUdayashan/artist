import 'package:artist/api/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Verification extends StatelessWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Lottie.asset(
              'assets/json/verification.json',
              height: Get.height / 2.4,
            ),
            const SizedBox(height: 20),
            Text(
              'Check your email',
              style: context.textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "We've sent email to your email addrress to verify your account\n"
              "Verify your account & come back to continue",
              textAlign: TextAlign.center,
              style: context.textTheme.headline3,
            ),
            const SizedBox(height: 25),
            TextButton(
              onPressed: () {
                ApiProvider().isVerified();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Get.offNamed('/signin'),
              child: const Text(
                'Resend verification email',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () => Get.offNamed('/signIn'),
              child: const Text(
                'login',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
