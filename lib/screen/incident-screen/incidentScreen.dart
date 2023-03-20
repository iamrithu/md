// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:md/config/config.dart';
import 'package:md/screen/check-screen/vehicleCheck/vehicleCheckScreen.dart';
import 'package:md/screen/driver-screen/driverScreen.dart';
import 'package:md/screen/report-screen/reportScreen.dart';
import 'package:md/screen/splash-screen/splashScreen.dart';
import 'package:md/widgets/globalButtonWidget.dart';

import '../../provider/provider.dart';
import '../login-screen/widget/customTextForm.dart';

class IncidentScreen extends ConsumerStatefulWidget {
  const IncidentScreen({Key? key}) : super(key: key);

  @override
  _IncidentScreenState createState() => _IncidentScreenState();
}

class _IncidentScreenState extends ConsumerState<IncidentScreen> {
  DateTime date = DateTime.now();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _witnessController = TextEditingController();
  final TextEditingController _statementController = TextEditingController();

  final TextEditingController _witnessNumberController =
      TextEditingController();

  bool isRememberMe = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _witnessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    IncidentScreen() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DriverScreen(),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Config.bg,
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            child: Column(
              children: [
                Container(
                  color: Config.theme,
                  width: width,
                  height: height * 0.07,
                  alignment: Alignment.centerLeft,
                  child: Row(children: [
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
                    ),
                  ]),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Reaport an  incident",
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
                        Row(
                          children: [
                            Text(
                              "Date of incident",
                              style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                  color: Config.black,
                                  fontSize: width / 28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    currentDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2200),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        date = value;
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Config.white,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${DateFormat("dd-MM-yyyy").format(date)}",
                                    style: GoogleFonts.mulish(
                                      textStyle: TextStyle(
                                        color: Config.black,
                                        fontSize: width / 30,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextForm(
                          hide: false,
                          width: width,
                          controller: _locationController,
                          lable: "Location",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextForm(
                          hide: false,
                          width: width,
                          controller: _witnessController,
                          lable: "Witnessed by",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextForm(
                          hide: false,
                          width: width,
                          controller: _witnessNumberController,
                          lable: "Phone Number of Witness",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextForm(
                          hide: false,
                          width: width,
                          controller: _statementController,
                          lable: "Brief Statement",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: width,
                  height: height * 0.07,
                  child: CustomButton(
                    boderColor: Config.white,
                    radius: 4,
                    txtColor: Config.white,
                    width: width,
                    height: height,
                    click: IncidentScreen,
                    bgColor: Config.theme,
                    lable: "Next",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
