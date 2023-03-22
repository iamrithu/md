// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:md/config/config.dart';
import 'package:md/provider/provider.dart';
import 'package:md/screen/driver-screen/driverScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../widgets/customImageButton.dart';
import '../../../widgets/globalButtonWidget.dart';

class SummaryScreen extends ConsumerStatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends ConsumerState<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    printPdf() async {
      // Create a new PDF document.
      final PdfDocument document = PdfDocument();
      final Directory? downloadsDir = await getApplicationSupportDirectory();
      final path = downloadsDir!.path;

// Add a PDF page and draw text.
      document.pages.add().graphics.drawString(
          'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 12),
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          bounds: const Rect.fromLTWH(0, 0, 150, 20));
// Save the document.
      File('${path}/${DateFormat("ddMMyyyyhhmmss").format(DateTime.now())}')
          .writeAsBytes(await document.save());
// Dispose the document.
      document.dispose();
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
                        ref.refresh(milage);
                        ref.refresh(visualProvider);
                        ref.refresh(vehicleDetailProvider);
                        ref.refresh(cabinProvider);
                        customAlert(
                          context: context,
                          height: height,
                          width: width,
                          content: "Previous Inspection Saved ....",
                          success: true,
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DriverScreen(),
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DriverScreen(),
                                ),
                              );
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
              Container(
                width: width,
                height: height * 0.75,
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
                              width: width * 0.2,
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
                                  CustomImageButton(
                                    btnType: "others",
                                    type: null,
                                    lable: null,
                                    height: height,
                                    click: () {},
                                    bg_color: Config.theme,
                                    img: "assets/edit.png",
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
                                    fontSize: width / 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Table(
                          border: TableBorder.all(),
                          children: [
                            if (ref.watch(visualProvider).isNotEmpty)
                              for (var i = 0;
                                  i < ref.watch(visualProvider).length;
                                  i++)
                                TableRow(
                                  children: [
                                    Container(
                                      color: Config.white,
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${ref.watch(visualProvider)[i]["name"]}",
                                        style: GoogleFonts.mulish(
                                          textStyle: TextStyle(
                                              color: Config.black,
                                              fontSize: width / 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Config.white,
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          ref.watch(visualProvider)[i]["status"]
                                              ? "Good"
                                              : "Bad",
                                          style: GoogleFonts.mulish(
                                            textStyle: TextStyle(
                                                color: Config.black,
                                                fontSize: width / 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                    fontSize: width / 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Table(
                          border: TableBorder.all(),
                          children: [
                            if (ref.watch(vehicleProvider).isNotEmpty)
                              for (var i = 0;
                                  i < ref.watch(vehicleProvider).length;
                                  i++)
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Config.white,
                                  ),
                                  children: [
                                    Container(
                                      color: Config.white,
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${ref.watch(vehicleProvider)[i]["name"]}",
                                        style: GoogleFonts.mulish(
                                          textStyle: TextStyle(
                                              color: Config.black,
                                              fontSize: width / 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   color: Config.white,
                                    //   padding: const EdgeInsets.all(10),
                                    //   child: Center(
                                    //     child: CustomImageButton(
                                    //       btnType: "comments",
                                    //       type: "",
                                    //       lable: "",
                                    //       height: height,
                                    //       click: () {},
                                    //       bg_color:
                                    //           ref.watch(vehicleProvider)[i]
                                    //                   ["status"]
                                    //               ? Config.bgSuc
                                    //               : Config.bgFail,
                                    //       img: ref.watch(cabinProvider)[i]
                                    //               ["status"]
                                    //           ? "assets/correct.png"
                                    //           : "assets/wrong.png",
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
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
                                                fontSize: width / 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                    fontSize: width / 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Table(
                          border: TableBorder.all(),
                          children: [
                            if (ref.watch(cabinProvider).isNotEmpty)
                              for (var i = 0;
                                  i < ref.watch(cabinProvider).length;
                                  i++)
                                TableRow(
                                  children: [
                                    Container(
                                      color: Config.white,
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${ref.watch(cabinProvider)[i]["name"]}",
                                        style: GoogleFonts.mulish(
                                          textStyle: TextStyle(
                                              color: Config.black,
                                              fontSize: width / 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Config.white,
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          ref.watch(cabinProvider)[i]["status"]
                                              ? "Good"
                                              : "Bad",
                                          style: GoogleFonts.mulish(
                                            textStyle: TextStyle(
                                                color: Config.black,
                                                fontSize: width / 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
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
                            content: "Previous Inspection Saved ....",
                            success: true,
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DriverScreen(),
                            ),
                          );
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
