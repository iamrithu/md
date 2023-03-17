// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/config.dart';

class CustomDetailContainer extends StatefulWidget {
  const CustomDetailContainer({
    super.key,
    required this.width,
    required this.height,
    required this.lable,
    required this.value,
    required this.img,
  });

  final double width;
  final double height;
  final String lable;
  final String value;
  final String img;

  @override
  State<CustomDetailContainer> createState() => _CustomDetailContainerState();
}

class _CustomDetailContainerState extends State<CustomDetailContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height * 0.1,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Config.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Config.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Container(
              width: widget.height * 0.065,
              height: widget.height * 0.065,
              decoration: BoxDecoration(
                color: Config.theme,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.asset(
                widget.img,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.lable,
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(
                              color: widget.lable ==
                                      "* Enter mileage reading or 0 if N/A to start report"
                                  ? Config.theme
                                  : Config.black,
                              fontSize: widget.width / 35,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Config.underLine))),
                      child: Text(
                        widget.value,
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(
                              color: Config.black,
                              fontSize: widget.width / 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
