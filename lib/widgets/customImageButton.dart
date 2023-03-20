import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/config.dart';
import '../provider/provider.dart';
import 'customImageAddingField.dart';
import 'globalButtonWidget.dart';

class CustomImageButton extends ConsumerStatefulWidget {
  const CustomImageButton({
    super.key,
    required this.height,
    required this.click,
    required this.img,
    required this.bg_color,
    required this.type,
    required this.lable,
    required this.btnType,
  });

  final double height;
  final Function click;
  final String img;
  final String btnType;
  final String? type;
  final String? lable;
  final Color bg_color;

  @override
  ConsumerState<CustomImageButton> createState() => _CustomImageButtonState();
}

class _CustomImageButtonState extends ConsumerState<CustomImageButton> {
  String comment = "Good";
  int? imgSetting = null;
  List<File> images = [];
  List<Map<String, dynamic>> dataList = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    reloadProvider(List<Map<String, dynamic>> val) {
      if (widget.type == "visual_check") {
        ref.read(visualProvider.notifier).state = [];
        ref.read(visualProvider.notifier).state = val;
        dataList = ref.watch(visualProvider);
      }
      if (widget.type == "Vehicle Checks") {
        ref.read(vehicleProvider.notifier).state = [];
        ref.read(vehicleProvider.notifier).state = val;
        dataList = ref.watch(vehicleProvider);
      }
      if (widget.type == "Cabin Checks") {
        ref.read(cabinProvider.notifier).state = [];
        ref.read(cabinProvider.notifier).state = val;
        dataList = ref.watch(cabinProvider);
      }
    }

    void commentFunction() {
      try {
        Map<String, dynamic> object =
            dataList.firstWhere((e) => e["name"] == widget.lable);
        setState(() {
          comment = object["comment"];
        });
      } catch (e) {
        setState(() {
          comment = "Good";
        });
      }
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10,
            backgroundColor: Config.bg,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              '${widget.type!}',
              style: GoogleFonts.mulish(
                textStyle: TextStyle(
                    color: Config.theme,
                    fontSize: width / 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            content: Container(
              width: 500,
              height: 200,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          '${widget.lable!} : Notes',
                          style: GoogleFonts.mulish(
                            textStyle: TextStyle(
                                color: Config.black,
                                fontSize: width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      initialValue: comment,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Config.white,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Config.theme),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Config.theme),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          comment = value;
                        });
                      },
                      minLines: 5,
                      maxLines: 5,
                    ),
                    CustomButton(
                      boderColor: Config.white,
                      radius: 4,
                      txtColor: Config.white,
                      bgColor: Config.theme,
                      click: () {
                        if (dataList.isEmpty) {
                          dataList.add({
                            "type": widget.type,
                            "name": widget.lable,
                            "comment": comment,
                            "status": true,
                            "image": images
                          });
                          reloadProvider(dataList);
                        }

                        try {
                          Map<String, dynamic> object = dataList
                              .firstWhere((e) => e["name"] == widget.lable);
                          object["comment"] = comment;
                          reloadProvider(dataList);
                        } catch (e) {
                          dataList.add({
                            "type": widget.type,
                            "name": widget.lable,
                            "comment": comment,
                            "status": true,
                            "image": images
                          });
                          reloadProvider(dataList);
                        }

                        Navigator.pop(context);
                      },
                      width: width,
                      height: widget.height * 0.07,
                      lable: "Add",
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    void statusFunction() {
      if (dataList.isEmpty) {
        setState(() {
          dataList.add({
            "type": widget.type,
            "name": widget.lable,
            "comment": comment,
            "status": false,
            "image": images
          });
        });
        reloadProvider(dataList);

        return;
      }
      try {
        Map<String, dynamic> object =
            dataList.firstWhere((e) => e["name"] == widget.lable);
        if (object["status"]) {
          object["status"] = false;
        } else {
          object["status"] = true;
        }
        reloadProvider(dataList);
      } catch (e) {
        setState(() {
          dataList.add({
            "type": widget.type,
            "name": widget.lable,
            "comment": comment,
            "status": false,
            "image": images
          });
        });
        reloadProvider(dataList);
      }
    }

    imageFunction() {
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return CustomImageAddingField(
            type: widget.type!,
            lable: widget.lable!,
            dataList: dataList,
          );
        },
      );
    }

    Widget isStatus() {
      try {
        Map<String, dynamic> object =
            dataList.firstWhere((e) => e["name"] == widget.lable);

        if (object["status"]) {
          return Image.asset("${widget.img}");
        } else {
          return Image.asset("assets/x.png");
        }
      } catch (e) {
        return Image.asset("${widget.img}");
      }
    }

    Color isColor() {
      try {
        Map<String, dynamic> object =
            dataList.firstWhere((e) => e["name"] == widget.lable);

        if (object["status"]) {
          return widget.bg_color;
        } else {
          return Config.bgFail;
        }
      } catch (e) {
        return widget.bg_color;
      }
    }

    return InkWell(
      onTap: () {
        // widget.click();

        if (widget.type == "visual_check") {
          dataList = [];
          dataList = ref.watch(visualProvider);
        }
        if (widget.type == "Vehicle Checks") {
          dataList = [];
          dataList = ref.watch(vehicleProvider);
        }
        if (widget.type == "Cabin Checks") {
          dataList = [];
          dataList = ref.watch(cabinProvider);
        }

        if (widget.btnType == "others") return;
        if (widget.btnType == "comments") return commentFunction();
        if (widget.btnType == "status") return statusFunction();
        if (widget.btnType == "image") return imageFunction();
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Container(
          width: widget.height * 0.04,
          height: widget.height * 0.04,
          decoration: BoxDecoration(
            color: widget.btnType == "status" ? isColor() : widget.bg_color,
            borderRadius: BorderRadius.circular(100),
          ),
          child:
              widget.btnType == "status" ? isStatus() : Image.asset(widget.img),
        ),
      ),
    );
  }
}
