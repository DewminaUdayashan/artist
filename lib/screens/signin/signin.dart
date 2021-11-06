import 'package:artist/screens/signin/setup_account.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

// CONSTANTS
import 'package:artist/shared/text.dart';

class Signin extends StatelessWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/json/signin_image.json'),
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
              height: 50,
            ),
            Material(
              color: Colors.black12.withOpacity(0.07),
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SetupAccount()));
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      // color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 20,
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Terms & Privacy Policy',
              style: GoogleFonts.montserrat(
                decoration: TextDecoration.underline,
                color: Colors.blueAccent,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ubuntu
// monsrat