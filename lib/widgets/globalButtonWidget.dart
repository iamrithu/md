import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/config.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.lable,
    required this.click,
    required this.bgColor,
    required this.txtColor,
    required this.radius,
  });

  final double width;
  final double height;
  final String lable;
  final Function click;
  final Color bgColor;
  final Color txtColor;
  final double radius;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: widget.bgColor,
          fixedSize: Size(widget.width, widget.height * 0.06),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius))),
      onPressed: () {
        widget.click();
      },
      child: Text(
        widget.lable,
        style: GoogleFonts.mulish(
          textStyle: TextStyle(
              color: widget.txtColor,
              fontSize: width / 30,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
