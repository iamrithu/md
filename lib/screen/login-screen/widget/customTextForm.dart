// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';

class CustomTextForm extends StatefulWidget {
  final TextEditingController? controller;
  final String? lable;
  final bool hide;
  const CustomTextForm({
    super.key,
    required this.width,
    required this.controller,
    required this.lable,
    required this.hide,
  });

  final double width;

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.lable!,
              style: GoogleFonts.mulish(
                textStyle: TextStyle(
                    color: Config.black,
                    fontSize: widget.width / 26,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          onTapOutside: (value) {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          controller: widget.controller,
          keyboardType: widget.lable == "Password"
              ? TextInputType.visiblePassword
              : widget.lable == "Phone Number of Witness"
                  ? TextInputType.phone
                  : TextInputType.text,
          obscureText: widget.hide,
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Config.white,
            contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Config.white),
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Config.white),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          // minLines: widget.lable == "Brief Statement" ? 3 : 1,
          maxLines: widget.lable == "Brief Statement" ? 5 : 1,
        )
      ],
    );
  }
}
