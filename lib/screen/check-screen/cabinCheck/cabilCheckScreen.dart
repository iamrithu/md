// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md/config/config.dart';
import 'package:md/screen/check-screen/vehicleCheck/vehicleCheckScreen.dart';
import 'package:md/screen/check-screen/visualCheck/visualCheckScreen.dart';
import 'package:md/screen/report-screen/reportScreen.dart';

import '../../../widgets/customCheckDetailField.dart';
import '../../../widgets/customImageButton.dart';
import '../../../widgets/globalButtonWidget.dart';
import '../../summary-screen.dart/summaryScreen.dart';

class CabinScreen extends StatefulWidget {
  const CabinScreen({Key? key}) : super(key: key);

  @override
  _CabinScreenState createState() => _CabinScreenState();
}

class _CabinScreenState extends State<CabinScreen> {
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
                            builder: (context) => VehicleScreen(),
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
                            "Cabin Checks",
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
                        lable: "Steering",
                        type: "Cabin Checks",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomCheckDetailScreen(
                        width: width,
                        height: height,
                        lable: "Wipers",
                        type: "Cabin Checks",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomCheckDetailScreen(
                        width: width,
                        height: height,
                        lable: "Washers",
                        type: "Cabin Checks",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomCheckDetailScreen(
                        width: width,
                        height: height,
                        lable: "Horn",
                        type: "Cabin Checks",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomCheckDetailScreen(
                        width: width,
                        height: height,
                        lable: "Brakes inc. ABS / EBS",
                        type: "Cabin Checks",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomCheckDetailScreen(
                        width: width,
                        height: height,
                        lable: "Mirrors / Glass / Visibility",
                        type: "Cabin Checks",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomCheckDetailScreen(
                        width: width,
                        height: height,
                        lable: "Truck Interior / Seat Belts",
                        type: "Cabin Checks",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomCheckDetailScreen(
                        width: width,
                        height: height,
                        lable: "Warning Lamps / MIL",
                        type: "Cabin Checks",
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
                                    builder: (context) => SummaryScreen(),
                                  ),
                                );
                              },
                              bgColor: Config.theme,
                              lable: "Submit",
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
