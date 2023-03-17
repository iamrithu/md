// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md/config/config.dart';
import 'package:md/screen/driver-screen/driverScreen.dart';
import 'package:md/screen/login-screen/widget/customTextForm.dart';
import 'package:md/widgets/globalButtonWidget.dart';

import '../../provider/provider.dart';
import '../splash-screen/splashScreen.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool isRememberMe = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    login() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DriverScreen(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Config.bg,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: width,
          height: height,
          child: Stack(
            children: [
              Container(
                width: width,
                height: height * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          child: Container(
                            color: Config.white,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Text(
                                  "ENG",
                                  style: GoogleFonts.mulish(
                                    textStyle: TextStyle(
                                        color: Config.black,
                                        fontSize: width / 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "assets/globe.png",
                                  scale: 1.1,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Config.theme)),
                          child: AnimatedContainer(
                            width: width * 0.4,
                            height: height * 0.1,
                            duration: const Duration(seconds: 1),
                            child: Center(
                                child: Image.asset(
                              "assets/logo.png",
                              scale: 1.5,
                            )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Login to your account",
                          style: GoogleFonts.mulish(
                            textStyle: TextStyle(
                                color: Config.black,
                                fontSize: width / 23,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  CustomTextForm(
                    hide: false,
                    width: width,
                    controller: null,
                    lable: "Email",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextForm(
                    hide: true,
                    width: width,
                    controller: null,
                    lable: "Password",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                            checkColor: Config.bg,
                            activeColor: Config.theme,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: BorderSide(color: Config.theme),
                            ),
                            side: BorderSide(color: Config.theme),
                            value: isRememberMe,
                            onChanged: (value) {
                              setState(() {
                                isRememberMe = !isRememberMe;
                              });
                            }),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Remember Me",
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(
                              color: Config.black,
                              fontSize: width / 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  CustomButton(
                    radius: 4,
                    txtColor: Config.white,
                    width: width,
                    height: height,
                    click: login,
                    bgColor: Config.theme,
                    lable: "Login",
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
