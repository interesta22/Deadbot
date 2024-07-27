import 'package:testt/util/consts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(this.ontap, this.title, this.img);
  String title;
  VoidCallback ontap;
  String img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          foregroundColor: Colors.grey,
          backgroundColor: Color(0xffF5F7F8),
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          fixedSize: Size(327, 52)
        ),
        onPressed: ontap,
        child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Image(image: AssetImage(img)),
                ),
                Text(title, style:  MyFonts.font13black),
              ],
            
        ),
      ),
    );
  }
}
