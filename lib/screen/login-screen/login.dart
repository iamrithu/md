// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md/config/config.dart';
import 'package:md/screen/driver-screen/driverScreen.dart';
import 'package:md/screen/login-screen/widget/customTextForm.dart';
import 'package:md/screen/splash-screen/splashScreen.dart';
import 'package:md/widgets/globalButtonWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api.dart';
import '../../provider/provider.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isRememberMe = false;
  bool isLoading = false;

  getLocal() async {
    final prefs = await SharedPreferences.getInstance();

    final bool? remember = prefs.getBool('remember');
    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');

    if (remember == true) {
      Api().Login(email!, password!).then((value) {
        if (value.statusCode == 200) {
          ref.read(userProvider.notifier).update(
                (state) => [],
              );
          ref.read(vehicleDetailProvider.notifier).update(
                (state) => [],
              );
          ref.read(assignDetailProvider.notifier).update(
                (state) => [],
              );
          ref.read(userProvider.notifier).update(
                (state) => value.data["user"],
              );
          ref.read(vehicleDetailProvider.notifier).update(
                (state) => value.data["vehicle"],
              );
          ref.read(assignDetailProvider.notifier).update(
                (state) => value.data["assign"],
              );
          ref.read(token.notifier).update(
                (state) => value.data["0"]["token"],
              );

          ref.read(isLogedIn.notifier).state = true;
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocal();
    Future.delayed(Duration(seconds: 3), () async {
      return ref.read(splashScreen.notifier).update((state) => false);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    localStore(bool remember, String? email, String? password) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('remember', remember);
      await prefs.setString('email', email!);
      await prefs.setString('password', password!);
    }

    login() {
      if (_emailController.text.trim().isEmpty ||
          _passwordController.text.trim().isEmpty) {
        return customAlert(
            context: context,
            height: height,
            width: width,
            content: "Please try again",
            success: false);
      }
      if (!_emailController.text.contains("@")) {
        return customAlert(
          context: context,
          height: height,
          width: width,
          content: "Invalid Email ",
          success: false,
        );
      }
      setState(() {
        isLoading = true;
      });

      if (isRememberMe) {
        localStore(
            isRememberMe, _emailController.text, _passwordController.text);
      } else {
        localStore(isRememberMe, "", "");
      }
      Api()
          .Login(_emailController.text, _passwordController.text)
          .then((value) {
        if (value.statusCode == 200) {
          ref.read(userProvider.notifier).update(
                (state) => [],
              );
          ref.read(vehicleDetailProvider.notifier).update(
                (state) => [],
              );
          ref.read(assignDetailProvider.notifier).update(
                (state) => [],
              );
          ref.read(userProvider.notifier).update(
                (state) => value.data["user"],
              );
          ref.read(vehicleDetailProvider.notifier).update(
                (state) => value.data["vehicle"],
              );
          ref.read(assignDetailProvider.notifier).update(
                (state) => value.data["assign"],
              );
          ref.read(token.notifier).update(
                (state) => value.data["0"]["token"],
              );
          ref.read(isLogedIn.notifier).state = true;
          setState(() {
            isLoading = false;
          });
          if (isRememberMe) {
            localStore(
                isRememberMe, _emailController.text, _passwordController.text);
          } else {
            localStore(isRememberMe, "", "");
          }

          return customAlert(
            context: context,
            height: height,
            width: width,
            content: "Hello, ${value.data["user"][0]["name"]}",
            success: true,
          );
        } else {
          setState(() {
            isLoading = false;
          });
          customAlert(
            context: context,
            height: height,
            width: width,
            content: "${value.data["error"]}",
            success: false,
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: Config.bg,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: width,
              height: height,
              child: Column(
                children: [
                  Container(
                    width: width,
                    height: height * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Card(
                        //       child: Container(
                        //         color: Config.white,
                        //         padding: EdgeInsets.all(5),
                        //         child: Row(
                        //           children: [
                        //             Text(
                        //               "ENG",
                        //               style: GoogleFonts.mulish(
                        //                 textStyle: TextStyle(
                        //                     color: Config.black,
                        //                     fontSize: width / 28,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //             ),
                        //             SizedBox(
                        //               width: 5,
                        //             ),
                        //             Image.asset(
                        //               "assets/globe.png",
                        //               scale: 1.1,
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
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
                        controller: _emailController,
                        lable: "Email",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextForm(
                        hide: true,
                        width: width,
                        controller: _passwordController,
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
                        boderColor: Config.white,
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
            if (ref.watch(splashScreen)) SplashScreen(),
            if (isLoading)
              Container(
                width: width,
                height: height,
                color: Color.fromARGB(82, 0, 0, 0),
                child: Center(
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000)),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator.adaptive(
                          backgroundColor: Config.bg,
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Config.theme)),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
