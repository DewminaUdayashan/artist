import 'package:artist/shared/instances.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    this.prefixIcon,
    this.onChanged,
  }) : super(key: key);

  final String hintText;
  final bool isPassword;
  final Widget? prefixIcon;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onChanged: onChanged ??
            (value) {
              if (isPassword) {
                appController.loginPw = value;
              } else {
                appController.loginEmail = value;
              }
            },
        obscureText: isPassword ? true : false,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          prefixIcon: prefixIcon ?? prefixIcon,
          helperStyle: context.textTheme.bodyText2,
        ),
      ),
    );
  }
}
