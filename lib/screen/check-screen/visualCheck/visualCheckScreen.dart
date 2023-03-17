// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md/config/config.dart';
import 'package:md/screen/report-screen/reportScreen.dart';

import '../../../widgets/customCheckDetailField.dart';
import '../../../widgets/customImageButton.dart';
import '../../../widgets/globalButtonWidget.dart';
import '../vehicleCheck/vehicleCheckScreen.dart';

class VisualCheckScreen extends StatefulWidget {
  const VisualCheckScreen({Key? key}) : super(key: key);

  @override
  _VisualCheckScreenState createState() => _VisualCheckScreenState();
}

class _VisualCheckScreenState extends State<VisualCheckScreen> {
  List<Map<String, dynamic>> visual_check = [
    {
      "name": "Front",
      "type": "visual_check",
    },
    {
      "name": "Near side",
      "type": "visual_check",
    },
    {
      "name": "Rear",
      "type": "visual_check",
    },
    {
      "name": "Off-side",
      "type": "visual_check",
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                            builder: (context) => ReportScreen(),
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
                            "Visual Damager",
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
                      for (var i = 0; i < visual_check.length; i++)
                        CustomCheckDetailScreen(
                          width: width,
                          height: height,
                          lable: visual_check[i]["name"],
                          type: visual_check[i]["type"],
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
                                    builder: (context) => VehicleScreen(),
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
