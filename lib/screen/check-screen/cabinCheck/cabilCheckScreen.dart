// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md/config/config.dart';
import 'package:md/provider/provider.dart';

import '../../../api/api.dart';
import '../../../widgets/customCheckDetailField.dart';
import '../../../widgets/globalButtonWidget.dart';
import '../../summary-screen.dart/summaryScreen.dart';

class CabinScreen extends ConsumerStatefulWidget {
  const CabinScreen({Key? key}) : super(key: key);

  @override
  _CabinScreenState createState() => _CabinScreenState();
}

class _CabinScreenState extends ConsumerState<CabinScreen> {
  List<Map<String, dynamic>> cabin_check = [];
  bool isLoading = false;
  String message = "";
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
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              child: Column(
                children: [
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
                                    Map<String, dynamic> object = {
                                      "reportno": ref.watch(reportNo),
                                      "mileage": ref.watch(milage)
                                    };
                                    setState(() {
                                      isLoading = true;
                                      message = "Generate Inspection";
                                    });

                                    Api()
                                        .inspection(
                                            ref.watch(token),
                                            ref.watch(assignDetailProvider)[0]
                                                ["id"],
                                            object)
                                        .then((value) {
                                      var data = value.data["data"];
                                      ref.read(inspectionId.notifier).update(
                                          (state) => value.data["data"]["id"]);
                                      if (value.statusCode == 200) {
                                        setState(() {
                                          message = "Visual Checking......";
                                        });
                                        Api()
                                            .check(
                                                ref.watch(token),
                                                "visual",
                                                ref.watch(visualProvider),
                                                data["id"])
                                            .then((value) {
                                          print(value.toString());
                                          if (value.statusCode == 200) {
                                            setState(() {
                                              message =
                                                  "Vehicle Checking......";
                                            });
                                            Api()
                                                .check(
                                                    ref.watch(token),
                                                    "vehicle",
                                                    ref.watch(vehicleProvider),
                                                    data["id"])
                                                .then((value) {
                                              if (value.statusCode == 200) {
                                                setState(() {
                                                  message =
                                                      "Cabin Checking......";
                                                });
                                                Api()
                                                    .check(
                                                        ref.watch(token),
                                                        "cabin",
                                                        ref.watch(
                                                            cabinProvider),
                                                        data["id"])
                                                    .then((value) {
                                                  if (value.statusCode == 200) {
                                                    setState(() {
                                                      message =
                                                          "Generate Summary......";
                                                    });

                                                    customAlert(
                                                      context: context,
                                                      height: height,
                                                      width: width,
                                                      content:
                                                          "Data Stored Successfully",
                                                      success: true,
                                                    );
                                                    setState(() {
                                                      isLoading = false;
                                                      message = "";
                                                    });
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            SummaryScreen(),
                                                      ),
                                                    );
                                                    return;
                                                  } else {
                                                    setState(() {
                                                      isLoading = false;
                                                      message = "";
                                                    });
                                                    return customAlert(
                                                      context: context,
                                                      height: height,
                                                      width: width,
                                                      content:
                                                          "Something went wrong on cabin check ",
                                                      success: false,
                                                    );
                                                  }
                                                });
                                              } else {
                                                setState(() {
                                                  isLoading = false;
                                                  message = "";
                                                });
                                                return customAlert(
                                                  context: context,
                                                  height: height,
                                                  width: width,
                                                  content:
                                                      "Something went wrong on vehicle check ",
                                                  success: false,
                                                );
                                              }
                                            });
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                              message = "";
                                            });
                                            customAlert(
                                              context: context,
                                              height: height,
                                              width: width,
                                              content:
                                                  "Something went wrong on visual check ",
                                              success: false,
                                            );
                                            return null;
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                          message = "";
                                        });
                                        customAlert(
                                          context: context,
                                          height: height,
                                          width: width,
                                          content: "Something Went Wrong",
                                          success: false,
                                        );
                                      }
                                    });
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
            if (isLoading)
              Container(
                width: width,
                height: height,
                color: Color.fromARGB(82, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
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
                    Center(
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000)),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "${message}",
                            style: GoogleFonts.mulish(
                              textStyle: TextStyle(
                                  color: Config.theme,
                                  fontSize: width / 35,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
