// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md/config/config.dart';
import 'package:md/screen/check-screen/cabinCheck/cabilCheckScreen.dart';
import 'package:md/screen/check-screen/visualCheck/visualCheckScreen.dart';
import 'package:md/screen/report-screen/reportScreen.dart';

import '../../../widgets/customCheckDetailField.dart';
import '../../../widgets/customImageButton.dart';
import '../../../widgets/globalButtonWidget.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                  children: [
                    InkWell(
                      splashColor: Config.white,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VisualCheckScreen(),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: height * 0.05,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.arrow_back_ios,
                              color: Config.white,
                              size: width / 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Back",
                              style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                    color: Config.white,
                                    fontSize: width / 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
                            "Vehicle Checks",
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
                      CustomCheckDetailScreen(
                        width: width,
                        height: height,
                        lable: "Adblue levels",
                        type: "Vehicle Checks",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomCheckDetailScreen(
                        width: width,
                        height: height,
                        lable: "Fuel/Oil Leaks",
                        type: "Vehicle Checks",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomCheckDetailScreen(
                        width: width,
                        height: height,
                        lable: "Lights",
                        type: "Vehicle Checks",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomCheckDetailScreen(
                        width: width,
                        height: height,
                        lable: "Indicators / Signals",
                        type: "Vehicle Checks",
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomButton(
                              radius: 4,
                              txtColor: Config.white,
                              width: width,
                              height: height,
                              click: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CabinScreen(),
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
