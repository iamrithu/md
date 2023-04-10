// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md/config/config.dart';
import 'package:md/provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/customImageButton.dart';
import '../../../widgets/globalButtonWidget.dart';
import '../../api/api.dart';

class SummaryScreen extends ConsumerStatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends ConsumerState<SummaryScreen> {
  List<String> viewList = [];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    printPdf() async {
      try {
        final url =
            'https://vehicle.paravsoftware.co.uk/pdf/${ref.watch(inspectionId)}'; // Replace with the path to your file
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url),
              mode: LaunchMode.externalNonBrowserApplication);
        } else {
          throw 'Could not launch $url';
        }
      } catch (e) {
        print(e);
      }
    }

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashColor: Config.white,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: height * 0.07,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.arrow_back_ios,
                              color: Config.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Back",
                              style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                    color: Config.white,
                                    fontSize: width / 34,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          CustomImageButton(
                            btnType: "others",
                            type: null,
                            lable: null,
                            height: height,
                            click: () {
                              ref.refresh(milage);
                              ref.refresh(visualProvider);
                              ref.refresh(vehicleProvider);
                              ref.refresh(cabinProvider);
                              customAlert(
                                context: context,
                                height: height,
                                width: width,
                                content: "Previous Inspection Saved ....",
                                success: true,
                              );
                              int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 5;
                              });
                            },
                            bg_color: Color.fromARGB(255, 238, 38, 85),
                            img: "assets/home.png",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Report Summary",
                              style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                    color: Config.black,
                                    fontSize: width / 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: width * 0.4,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomImageButton(
                                    btnType: "others",
                                    type: null,
                                    lable: null,
                                    height: height,
                                    click: () {
                                      printPdf();
                                    },
                                    bg_color: Config.theme,
                                    img: "assets/printer.png",
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Visual Check",
                              style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                    color: Config.theme,
                                    fontSize: width / 34,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (ref.watch(visualProvider).isNotEmpty)
                          for (var i = 0;
                              i < ref.watch(visualProvider).length;
                              i++)
                            Column(
                              children: [
                                Container(
                                  width: width,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Config.white)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: width * 0.6,
                                        color: Config.white,
                                        padding: const EdgeInsets.all(10),
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              "${ref.watch(visualProvider)[i]["name"]}",
                                              style: GoogleFonts.mulish(
                                                textStyle: TextStyle(
                                                    color: Config.black,
                                                    fontSize: width / 34,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.2,
                                        color: Config.white,
                                        padding: const EdgeInsets.all(10),
                                        child: Center(
                                          child: Text(
                                            ref.watch(visualProvider)[i]
                                                    ["status"]
                                                ? "Good"
                                                : "Bad",
                                            style: GoogleFonts.mulish(
                                              textStyle: TextStyle(
                                                  color: Config.black,
                                                  fontSize: width / 34,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            if (viewList.isEmpty) {
                                              return setState(() {
                                                viewList.add(
                                                    ref.watch(visualProvider)[i]
                                                        ["name"]);
                                              });
                                            }
                                            try {
                                              if (viewList.contains(
                                                  ref.watch(visualProvider)[i]
                                                      ["name"])) {
                                                setState(() {
                                                  viewList.remove(ref.watch(
                                                          visualProvider)[i]
                                                      ["name"]);
                                                });
                                              } else {
                                                setState(() {
                                                  viewList.add(ref.watch(
                                                          visualProvider)[i]
                                                      ["name"]);
                                                });
                                              }
                                            } catch (e) {
                                              setState(() {
                                                viewList.add(
                                                    ref.watch(visualProvider)[i]
                                                        ["name"]);
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: height * 0.07,
                                            padding: const EdgeInsets.all(10),
                                            color: Config.white,
                                            child: Icon(
                                              Icons.visibility,
                                              color: viewList.contains(
                                                      ref.watch(
                                                              visualProvider)[i]
                                                          ["name"])
                                                  ? Config.theme
                                                  : Config.black,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Config.underLine),
                                    color: Config.bg,
                                  ),
                                  width: width,
                                  height: viewList.contains(
                                          ref.watch(visualProvider)[i]["name"])
                                      ? ref
                                              .watch(visualProvider)[i]["image"]
                                              .isEmpty
                                          ? height * 0.07
                                          : height * 0.2
                                      : 0,
                                  child: ref
                                          .watch(visualProvider)[i]["image"]
                                          .isEmpty
                                      ? Center(
                                          child: Text(
                                            "No image found",
                                            style: GoogleFonts.mulish(
                                              textStyle: TextStyle(
                                                  color: Config.theme,
                                                  fontSize: width / 40,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.all(5),
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              for (var j = 0;
                                                  j <
                                                      ref
                                                          .watch(visualProvider)[
                                                              i]["image"]
                                                          .length;
                                                  j++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    elevation: 10,
                                                    child: Container(
                                                      width: width * 0.4,
                                                      height: height * 0.17,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color:
                                                                Config.white),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.file(
                                                          ref.watch(
                                                                  visualProvider)[
                                                              i]["image"][j],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                )
                              ],
                            ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Vehicle Check",
                              style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                    color: Config.theme,
                                    fontSize: width / 34,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (ref.watch(vehicleProvider).isNotEmpty)
                          for (var i = 0;
                              i < ref.watch(vehicleProvider).length;
                              i++)
                            Column(
                              children: [
                                Container(
                                  width: width,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Config.white)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: width * 0.6,
                                        color: Config.white,
                                        padding: const EdgeInsets.all(10),
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              "${ref.watch(vehicleProvider)[i]["name"]}",
                                              style: GoogleFonts.mulish(
                                                textStyle: TextStyle(
                                                    color: Config.black,
                                                    fontSize: width / 34,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.2,
                                        color: Config.white,
                                        padding: const EdgeInsets.all(10),
                                        child: Center(
                                          child: Text(
                                            ref.watch(vehicleProvider)[i]
                                                    ["status"]
                                                ? "Good"
                                                : "Bad",
                                            style: GoogleFonts.mulish(
                                              textStyle: TextStyle(
                                                  color: Config.black,
                                                  fontSize: width / 34,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            if (viewList.isEmpty) {
                                              return setState(() {
                                                viewList.add(ref.watch(
                                                        vehicleProvider)[i]
                                                    ["name"]);
                                              });
                                            }
                                            try {
                                              if (viewList.contains(
                                                  ref.watch(vehicleProvider)[i]
                                                      ["name"])) {
                                                setState(() {
                                                  viewList.remove(ref.watch(
                                                          vehicleProvider)[i]
                                                      ["name"]);
                                                });
                                              } else {
                                                setState(() {
                                                  viewList.add(ref.watch(
                                                          vehicleProvider)[i]
                                                      ["name"]);
                                                });
                                              }
                                            } catch (e) {
                                              setState(() {
                                                viewList.add(ref.watch(
                                                        vehicleProvider)[i]
                                                    ["name"]);
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: height * 0.07,
                                            padding: const EdgeInsets.all(10),
                                            color: Config.white,
                                            child: Icon(
                                              Icons.visibility,
                                              color: viewList.contains(
                                                      ref.watch(
                                                              vehicleProvider)[
                                                          i]["name"])
                                                  ? Config.theme
                                                  : Config.black,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Config.underLine),
                                    color: Config.bg,
                                  ),
                                  width: width,
                                  height: viewList.contains(
                                          ref.watch(vehicleProvider)[i]["name"])
                                      ? ref
                                              .watch(vehicleProvider)[i]
                                                  ["image"]
                                              .isEmpty
                                          ? height * 0.07
                                          : height * 0.2
                                      : 0,
                                  child: ref
                                          .watch(vehicleProvider)[i]["image"]
                                          .isEmpty
                                      ? Center(
                                          child: Text(
                                            "No image found",
                                            style: GoogleFonts.mulish(
                                              textStyle: TextStyle(
                                                  color: Config.theme,
                                                  fontSize: width / 40,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.all(5),
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              for (var j = 0;
                                                  j <
                                                      ref
                                                          .watch(vehicleProvider)[
                                                              i]["image"]
                                                          .length;
                                                  j++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    elevation: 10,
                                                    child: Container(
                                                      width: width * 0.4,
                                                      height: height * 0.17,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color:
                                                                Config.white),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.file(
                                                          ref.watch(
                                                                  vehicleProvider)[
                                                              i]["image"][j],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                )
                              ],
                            ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Cabin Check",
                              style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                    color: Config.theme,
                                    fontSize: width / 34,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (ref.watch(cabinProvider).isNotEmpty)
                          for (var i = 0;
                              i < ref.watch(cabinProvider).length;
                              i++)
                            Column(
                              children: [
                                Container(
                                  width: width,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Config.white)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: width * 0.6,
                                        color: Config.white,
                                        padding: const EdgeInsets.all(10),
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              "${ref.watch(cabinProvider)[i]["name"]}",
                                              style: GoogleFonts.mulish(
                                                textStyle: TextStyle(
                                                    color: Config.black,
                                                    fontSize: width / 34,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.2,
                                        color: Config.white,
                                        padding: const EdgeInsets.all(10),
                                        child: Center(
                                          child: Text(
                                            ref.watch(cabinProvider)[i]
                                                    ["status"]
                                                ? "Good"
                                                : "Bad",
                                            style: GoogleFonts.mulish(
                                              textStyle: TextStyle(
                                                  color: Config.black,
                                                  fontSize: width / 34,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            if (viewList.isEmpty) {
                                              return setState(() {
                                                viewList.add(
                                                    ref.watch(cabinProvider)[i]
                                                        ["name"]);
                                              });
                                            }
                                            try {
                                              if (viewList.contains(
                                                  ref.watch(cabinProvider)[i]
                                                      ["name"])) {
                                                setState(() {
                                                  viewList.remove(ref.watch(
                                                          cabinProvider)[i]
                                                      ["name"]);
                                                });
                                              } else {
                                                setState(() {
                                                  viewList.add(ref.watch(
                                                          cabinProvider)[i]
                                                      ["name"]);
                                                });
                                              }
                                            } catch (e) {
                                              setState(() {
                                                viewList.add(
                                                    ref.watch(cabinProvider)[i]
                                                        ["name"]);
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: height * 0.07,
                                            padding: const EdgeInsets.all(10),
                                            color: Config.white,
                                            child: Icon(
                                              Icons.visibility,
                                              color: viewList.contains(
                                                      ref.watch(
                                                              cabinProvider)[i]
                                                          ["name"])
                                                  ? Config.theme
                                                  : Config.black,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Config.underLine),
                                    color: Config.bg,
                                  ),
                                  width: width,
                                  height: viewList.contains(
                                          ref.watch(cabinProvider)[i]["name"])
                                      ? ref
                                              .watch(cabinProvider)[i]["image"]
                                              .isEmpty
                                          ? height * 0.07
                                          : height * 0.2
                                      : 0,
                                  child: ref
                                          .watch(cabinProvider)[i]["image"]
                                          .isEmpty
                                      ? Center(
                                          child: Text(
                                            "No image found",
                                            style: GoogleFonts.mulish(
                                              textStyle: TextStyle(
                                                  color: Config.theme,
                                                  fontSize: width / 40,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.all(5),
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              for (var j = 0;
                                                  j <
                                                      ref
                                                          .watch(cabinProvider)[
                                                              i]["image"]
                                                          .length;
                                                  j++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    elevation: 10,
                                                    child: Container(
                                                      width: width * 0.4,
                                                      height: height * 0.17,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color:
                                                                Config.white),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.file(
                                                          ref.watch(
                                                                  cabinProvider)[
                                                              i]["image"][j],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                )
                              ],
                            ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: width,
                height: height * 0.09,
                child: Padding(
                  padding: EdgeInsets.all(height * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        boderColor: Config.white,
                        radius: 4,
                        txtColor: Config.white,
                        width: width,
                        height: height,
                        click: () {
                          ref.refresh(milage);
                          ref.refresh(visualProvider);
                          ref.refresh(vehicleProvider);
                          ref.refresh(cabinProvider);
                          customAlert(
                            context: context,
                            height: height,
                            width: width,
                            content: "Inspection Saved",
                            success: true,
                          );
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 5;
                          });
                        },
                        bgColor: Config.theme,
                        lable: "Go Home",
                      ),
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
