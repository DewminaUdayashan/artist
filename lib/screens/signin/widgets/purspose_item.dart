import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class PurposeItem extends StatelessWidget {
  const PurposeItem(
      {Key? key,
      required this.isChecked,
      required this.icon,
      required this.title,
      required this.description})
      : super(key: key);
  final bool isChecked;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      // height: 70,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isChecked ? Colors.blue[50] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color:
                isChecked ? const Color(0xff35b7f2) : const Color(0xfff1f1f1),
            width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: isChecked ? const Color(0xff35B7F1) : Colors.grey[200],
                borderRadius: BorderRadius.circular(25)),
            child: Icon(
              icon,
              color: isChecked ? Colors.white : Colors.grey[500],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: context.textTheme.headline2!.copyWith(
                    color: isChecked ? Colors.black87 : Colors.black54,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  style: context.textTheme.bodyText2!.copyWith(
                    color: isChecked ? Colors.black54 : Colors.black38,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                color: isChecked ? const Color(0xff35B7F1) : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isChecked
                      ? const Color(0xff35b7f2)
                      : const Color(0xfff1f1f1),
                )),
            child: const Icon(
              Icons.done,
              color: Colors.white,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
