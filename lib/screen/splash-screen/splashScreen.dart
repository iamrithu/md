import 'package:flutter/material.dart';
import 'package:md/config/config.dart';
import 'package:md/screen/login-screen/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimated = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Config.bg,
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Config.theme)),
            child: AnimatedContainer(
              width: isAnimated ? width * 0.4 : 0,
              height: isAnimated ? height * 0.1 : 0,
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
    );
  }
}
