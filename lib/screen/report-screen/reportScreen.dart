// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:md/config/config.dart';
import 'package:md/provider/provider.dart';
import 'package:md/screen/driver-screen/driverScreen.dart';

import '../../widgets/customDetailContainer.dart';
import '../../widgets/globalButtonWidget.dart';
import '../check-screen/visualCheck/visualCheckScreen.dart';
import '../incident-screen/incidentScreen.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final data = ref.watch(vehicleDetailProvider)[0];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Config.theme,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Config.white,
            ),
          ),
        ),
        backgroundColor: Config.bg,
        body: Container(
          width: width,
          height: height,
          child: Column(
            children: [
              // Container(
              //   color: Config.theme,
              //   width: width,
              //   height: height * 0.07,
              //   alignment: Alignment.centerLeft,
              //   child: Row(
              //     children: [
              //       InkWell(
              //         splashColor: Config.white,
              //         onTap: () {
              //           Navigator.of(context).push(
              //             MaterialPageRoute(
              //               builder: (context) => DriverScreen(),
              //             ),
              //           );
              //         },
              //         child: SizedBox(
              //           height: height * 0.05,
              //           child: Row(
              //             children: [
              //               SizedBox(
              //                 width: 20,
              //               ),
              //               Icon(
              //                 Icons.arrow_back_ios,
              //                 color: Config.white,
              //                 size: width / 30,
              //               ),
              //               SizedBox(
              //                 width: 10,
              //               ),
              //               Text(
              //                 "Back",
              //                 style: GoogleFonts.mulish(
              //                   textStyle: TextStyle(
              //                       color: Config.white,
              //                       fontSize: width / 30,
              //                       fontWeight: FontWeight.bold),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Start Report",
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
                        img: "assets/file-text.png",
                        lable: "Report",
                        value:
                            "${data["number_plate"]}-${DateFormat("ddMMyyyy-hhmmss").format(DateTime.now())}",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDetailContainer(
                        isText: false,
                        width: width,
                        height: height,
                        img: "assets/clock.png",
                        lable: "Date",
                        value:
                            "${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDetailContainer(
                        isText: false,
                        width: width,
                        height: height,
                        img: "assets/truck.png",
                        lable: "Number Plate",
                        value: "${data["number_plate"]}",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDetailContainer(
                        isText: true,
                        width: width,
                        height: height,
                        img: "assets/sunrise.png",
                        lable:
                            "* Enter mileage reading or 0 if N/A to start report",
                        value: "45083",
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomButton(
                              radius: 4,
                              txtColor: Config.white,
                              boderColor: Config.white,
                              width: width,
                              height: height,
                              click: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => IncidentScreen(),
                                  ),
                                );
                              },
                              bgColor: Config.theme,
                              lable: "Incident",
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            CustomButton(
                              radius: 4,
                              boderColor: Config.white,
                              txtColor: Config.white,
                              width: width,
                              height: height,
                              click: () {
                                if (ref.watch(milage).isEmpty) {
                                  return customAlert(
                                      context: context,
                                      height: height,
                                      width: width,
                                      content: "Please Enter Mileage Values",
                                      success: false);
                                }
                                ref.read(reportNo.notifier).update((state) =>
                                    "${data["number_plate"]}-${DateFormat("ddMMyyyy-hhmmss").format(DateTime.now())}");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => VisualCheckScreen(),
                                  ),
                                );
                              },
                              bgColor: Config.theme,
                              lable: "Report",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
