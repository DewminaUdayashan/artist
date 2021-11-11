import 'package:artist/helpers/storage_helper.dart';
import 'package:artist/shared/instances.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInHelper {
  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> continueWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user != null) {
      appController.currentUser.value.name = userCredential.user!.displayName;
      appController.currentUser.value.email = userCredential.user!.email;
      appController.currentUser.value.mainPurpose = 0;
      // appController.currentUser.value.joinedDate = DateTime.now().toString();
      if (StorageHelper.isFirstTime()) {
        Get.offAllNamed('/setup');
      } else {
        appController.markAppOpened();
      }
    }
  }

  static Future<void> signInwithPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential uc = await auth.createUserWithEmailAndPassword(
        email: 'dewminaudayashan@gmail.com',
        password: 'passwordddd',
      );

      uc.user!.sendEmailVerification();
      if (uc.user!.emailVerified) {
        print('verified');
      } else {
        print('not verified');
        verifyEmail();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    verifyEmail();
  }

  static Future<void> verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  static void checkEmail() {
    FirebaseAuth.instance.currentUser!.reload();
    print(FirebaseAuth.instance.currentUser!.emailVerified);
  }
}
