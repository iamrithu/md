import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Config {
  static const String URL = "https://vehicle.paravsoftware.co.uk/";
  static const Color theme = Color(0xFFBB1138);
  static const Color bg = Color(0xFFF2F1FF);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color underLine = Color.fromARGB(197, 206, 205, 205);
  static const Color bgImg = Color(0xFF1017B1);
  static const Color bgCmd = Color(0xFFE0A32E);
  static const Color bgSuc = Color(0xFF309f48);
  static const Color bgFail = Color(0xFFD42A37);
}

customAlert({context, width, height, success, content, String? content2}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: success
                ? Color.fromARGB(255, 231, 250, 231)
                : Color.fromARGB(255, 250, 233, 232),
          ),
          width: width * 0.5,
          height: width < 500 ? height * 0.08 : height * 0.06,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                child: !success
                    ? Image.asset('assets/error.png')
                    : Image.asset('assets/success.png'),
              ),
              SizedBox(width: width * 0.05),
              Expanded(
                child: Wrap(
                  children: [
                    Text(
                      content,
                      style: GoogleFonts.ptSans(
                        fontWeight: FontWeight.w400,
                        color: !success ? Config.bgFail : Config.bgSuc,
                        fontSize: width < 500 ? width / 32 : width / 48,
                      ),
                    ),
                    if (content2 != null)
                      Text(
                        content2,
                        style: GoogleFonts.ptSans(
                          fontWeight: FontWeight.w600,
                          color: Config.black,
                          fontSize: width < 500 ? width / 32 : width / 48,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      duration: Duration(milliseconds: 2000),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
