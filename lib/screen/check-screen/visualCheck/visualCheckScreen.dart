// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md/config/config.dart';
import 'package:md/screen/report-screen/reportScreen.dart';

import '../../../provider/provider.dart';
import '../../../widgets/customCheckDetailField.dart';
import '../../../widgets/customImageButton.dart';
import '../../../widgets/globalButtonWidget.dart';
import '../vehicleCheck/vehicleCheckScreen.dart';

class VisualCheckScreen extends ConsumerStatefulWidget {
  const VisualCheckScreen({Key? key}) : super(key: key);

  @override
  _VisualCheckScreenState createState() => _VisualCheckScreenState();
}

class _VisualCheckScreenState extends ConsumerState<VisualCheckScreen> {
  List<Map<String, dynamic>> visual_check = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      visual_check = ref.read(visualProvider);
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
        body: Container(
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
                            "Visual Check",
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
                              boderColor: Config.white,
                              radius: 4,
                              txtColor: Config.white,
                              width: width,
                              height: height,
                              click: () {
                                for (var i = 0; i < visual_check.length; i++) {
                                  if (visual_check[i]["image"].isEmpty) {
                                    customAlert(
                                        context: context,
                                        height: height,
                                        width: width,
                                        content: "Please add an image ",
                                        success: false,
                                        content2:
                                            "\"${visual_check[i]["name"]}\"");
                                    return;
                                  }
                                }

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
