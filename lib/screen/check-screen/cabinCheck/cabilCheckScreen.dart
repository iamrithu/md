// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md/config/config.dart';
import 'package:md/provider/provider.dart';
import 'package:md/screen/check-screen/vehicleCheck/vehicleCheckScreen.dart';
import 'package:md/screen/check-screen/visualCheck/visualCheckScreen.dart';
import 'package:md/screen/report-screen/reportScreen.dart';

import '../../../widgets/customCheckDetailField.dart';
import '../../../widgets/customImageButton.dart';
import '../../../widgets/globalButtonWidget.dart';
import '../../summary-screen.dart/summaryScreen.dart';

class CabinScreen extends ConsumerStatefulWidget {
  const CabinScreen({Key? key}) : super(key: key);

  @override
  _CabinScreenState createState() => _CabinScreenState();
}

class _CabinScreenState extends ConsumerState<CabinScreen> {
  List<Map<String, dynamic>> cabin_check = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      cabin_check = ref.read(cabinProvider);
    });
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
                      for (var i = 0; i < cabin_check.length; i++)
                        CustomCheckDetailScreen(
                          width: width,
                          height: height,
                          lable: cabin_check[i]["name"],
                          type: cabin_check[i]["type"],
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
                                for (var i = 0; i < cabin_check.length; i++) {
                                  if (cabin_check[i]["image"].isEmpty) {
                                    customAlert(
                                        context: context,
                                        height: height,
                                        width: width,
                                        content: "Kindly add images for ",
                                        success: false,
                                        content2:
                                            " ${cabin_check[i]["type"]}/${cabin_check[i]["name"]}");
                                    return;
                                  }
                                }
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
