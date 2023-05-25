import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/config.dart';
import '../provider/provider.dart';
import 'customImageButton.dart';

class CustomCheckDetailScreen extends ConsumerStatefulWidget {
  const CustomCheckDetailScreen({
    super.key,
    required this.width,
    required this.height,
    required this.lable,
    required this.type,
  });

  final double width;
  final String lable;
  final String type;
  final double height;

  @override
  ConsumerState<CustomCheckDetailScreen> createState() =>
      _CustomCheckDetailScreenState();
}

class _CustomCheckDetailScreenState
    extends ConsumerState<CustomCheckDetailScreen> {
  List<Map<String, dynamic>> dataList = [];

  @override
  Widget build(BuildContext context) {
    String isStatus() {
      if (widget.type == "visual_check") {
        dataList = ref.watch(visualProvider);
      }
      if (widget.type == "Vehicle Checks") {
        dataList = ref.watch(vehicleProvider);
      }
      if (widget.type == "Cabin Checks") {
        dataList = ref.watch(cabinProvider);
      }
      try {
        Map<String, dynamic> object =
            dataList.firstWhere((e) => e["name"] == widget.lable);

        if (object["status"]) {
          return "assets/correct.png";
        } else {
          return "assets/x.png";
        }
      } catch (e) {
        return "assets/correct.png";
      }
    }

    bool isAdded() {
      if (widget.type == "visual_check") {
        dataList = ref.watch(visualProvider);
      }
      if (widget.type == "Vehicle Checks") {
        dataList = ref.watch(vehicleProvider);
      }
      if (widget.type == "Cabin Checks") {
        dataList = ref.watch(cabinProvider);
      }
      try {
        Map<String, dynamic> object =
            dataList.firstWhere((e) => e["name"] == widget.lable);
        if (object["image"].isEmpty) {
          return false;
        }
        return true;
      } catch (e) {
        return false;
      }
    }

    Color isColor() {
      try {
        if (widget.type == "visual_check") {
          dataList = ref.watch(visualProvider);
        }
        if (widget.type == "Vehicle Checks") {
          dataList = ref.watch(vehicleProvider);
        }
        if (widget.type == "Cabin Checks") {
          dataList = ref.watch(cabinProvider);
        }
        Map<String, dynamic> object =
            dataList.firstWhere((e) => e["name"] == widget.lable);

        if (object["status"]) {
          return Config.bgSuc;
        } else {
          return Config.bgFail;
        }
      } catch (e) {
        return Config.bgSuc;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(bottom: 10),
      width: widget.width,
      height: widget.height * 0.06,
      decoration: BoxDecoration(
          color: Config.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
              color: isAdded()
                  ? Color.fromARGB(255, 149, 255, 172)
                  : Color.fromARGB(255, 255, 149, 156))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.lable,
              style: GoogleFonts.mulish(
                textStyle: TextStyle(
                    color: Config.black,
                    fontSize: widget.width / 28,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            width: widget.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageButton(
                  btnType: "image",
                  type: widget.type,
                  lable: widget.lable,
                  height: widget.height,
                  click: () {},
                  bg_color: Config.bgImg,
                  img: "assets/pic.png",
                ),
                CustomImageButton(
                  btnType: "comments",
                  type: widget.type,
                  lable: widget.lable,
                  height: widget.height,
                  click: () {},
                  bg_color: Config.bgCmd,
                  img: "assets/comment.png",
                ),
                CustomImageButton(
                  btnType: "status",
                  type: widget.type,
                  lable: widget.lable,
                  height: widget.height,
                  click: () {},
                  bg_color: isColor(),
                  img: isStatus(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
