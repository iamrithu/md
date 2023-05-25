// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md/config/config.dart';
import 'package:md/provider/provider.dart';
import 'package:md/screen/login-screen/login.dart';
import 'package:md/screen/report-screen/reportScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/customDetailContainer.dart';
import '../../widgets/globalButtonWidget.dart';

class DriverScreen extends ConsumerStatefulWidget {
  const DriverScreen({Key? key}) : super(key: key);

  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends ConsumerState<DriverScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final data = ref.watch(userProvider)[0];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Config.bg,
        body: Container(
          width: width,
          height: height,
          child: Column(
            children: [
              Container(
                color: Config.theme,
                width: width,
                height: height * 0.07,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(4),
                    //     // side: const BorderSide(color: Config.theme),
                    //   ),
                    //   margin: EdgeInsets.only(
                    //       left: 12, top: 6, right: 6, bottom: 6),
                    //   child: Center(
                    //       child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(4),
                    //     child: Image.asset(
                    //       "assets/logo.png",
                    //       scale: 1.5,
                    //     ),
                    //   )),
                    // ),
                    // InkWell(
                    //   splashColor: Config.white,
                    //   onTap: () {
                    //     SystemNavigator.pop();
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 20.0),
                    //     child: Icon(
                    //       Icons.arrow_back_ios,
                    //       color: Config.white,
                    //     ),
                    //   ),

                    // ),
                    InkWell(
                      splashColor: Config.white,
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();

                        await prefs.setBool('remember', false);

                        await prefs.setString('email', "");

                        await prefs.setString('password', "");
                        ref.refresh(milage);
                        ref.refresh(incidentProvider);
                        ref.refresh(visualProvider);
                        ref.refresh(vehicleProvider);
                        ref.refresh(cabinProvider);
                        ref.refresh(token);
                        ref.refresh(isLogedIn);
                      },
                      child: SizedBox(
                        height: height * 0.05,
                        child: Row(
                          children: [
                            Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Container(
                                width: 30,
                                height: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.logout,
                                    color: Config.theme,
                                    size: width / 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Driver",
                            style: GoogleFonts.mulish(
                              textStyle: TextStyle(
                                  color: Config.black,
                                  fontSize: width / 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomDetailContainer(
                        isText: false,
                        width: width,
                        height: height,
                        img: "assets/user.png",
                        lable: "Driver Name",
                        value: "${data["name"]}",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDetailContainer(
                        isText: false,
                        width: width,
                        height: height,
                        img: "assets/briefcase.png",
                        lable: "Company",
                        value: "${data["company"]}",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDetailContainer(
                        isText: false,
                        width: width,
                        height: height,
                        img: "assets/mail.png",
                        lable: "Delivery Email",
                        value: "${data["email"]}",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDetailContainer(
                        isText: false,
                        width: width,
                        height: height,
                        img: "assets/phone.png",
                        lable: "Phone",
                        value: "${data["mobile"]}",
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomButton(
                              boderColor: Config.white,
                              radius: 4,
                              txtColor: Config.white,
                              width: width,
                              height: height,
                              click: () {
                                if (ref.watch(vehicleDetailProvider)[0] ==
                                    null) {
                                  return customAlert(
                                    context: context,
                                    height: height,
                                    width: width,
                                    content:
                                        "You are  not assigned  to any vehicle",
                                    success: false,
                                  );
                                }
                                // Navigator.push(
                                //     context,
                                //     PageTransition(
                                //         type: PageTransitionType.size,
                                //         duration: Duration(milliseconds: 300),
                                //         alignment: Alignment.topRight,
                                //         child: ReportScreen(),
                                //         isIos: true));

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ReportScreen(),
                                  ),
                                );
                              },
                              bgColor: Config.theme,
                              lable: "Next",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
