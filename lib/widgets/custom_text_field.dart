import 'package:testt/util/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  String ?hint;
  Function(String)? onchanged;
  IconData? icon;
  final TextEditingController? controller;
  CustomTextField({this.hint, this.onchanged, this.icon, this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // ignore: body_might_complete_normally_nullable
      validator: (data) {
        if (data!.isEmpty) {
          return 'Required';
        }
      },
      onChanged: widget.onchanged,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        hintText: widget.hint,
        hintStyle: MyFonts.font13grey,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: Icon(
            widget.icon,
            color: Color(0xffE4003A),
            size: 21,
          ),
        ),
        border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xffE4003A))),
      ),
    );
  }
}
