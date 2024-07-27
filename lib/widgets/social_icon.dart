import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SocialIcon extends StatelessWidget {
  SocialIcon(this.img, this.onTap);
  String img;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      label: Image(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.contain,
          image: AssetImage(img)),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.grey,
        backgroundColor: Color(0xffF5F7F8),
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        fixedSize: Size(70, 47),
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
