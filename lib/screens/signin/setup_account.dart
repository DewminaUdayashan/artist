import 'package:artist/screens/home/home.dart';
import 'package:artist/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

// WIDGETS
import 'package:artist/screens/signin/widgets/purspose_item.dart';

class SetupAccount extends StatefulWidget {
  const SetupAccount({Key? key}) : super(key: key);

  @override
  State<SetupAccount> createState() => _SetupAccountState();
}

class _SetupAccountState extends State<SetupAccount> {
  String selectedChoise = 'find';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Choose', style: context.textTheme.headline1),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('One',
                      style: context.textTheme.headline1!
                          .copyWith(color: primaryColor))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    'Are you looking for new job or',
                    style: context.textTheme.bodyText1,
                    // style: GoogleFonts.aBeeZee(
                    //   textStyle: const TextStyle(
                    //       color: Colors.black54,
                    //       letterSpacing: .5,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w600),
                    // ),
                  ),
                  Text(
                    'looking for new employee?',
                    style: context.textTheme.bodyText1,
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: <Widget>[
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1500),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedChoise = 'find';
                        });
                      },
                      child: PurposeItem(
                        isChecked: selectedChoise == 'find' ? true : false,
                        icon: Icons.business_center_rounded,
                        title: 'Find a job',
                        description:
                            "It's easy to find your dreem jobs here with us",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1500),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedChoise = 'new';
                        });
                      },
                      child: PurposeItem(
                        isChecked: selectedChoise == 'new' ? true : false,
                        icon: Icons.person,
                        title: 'New employee',
                        description:
                            "It's easy to find your employees here with us",
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Material(
                color: primaryColor,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/home');
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
                      child: const Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
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
