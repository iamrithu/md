// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:md/provider/provider.dart';

import '../config/config.dart';

class CustomDetailContainer extends ConsumerStatefulWidget {
  const CustomDetailContainer({
    super.key,
    required this.width,
    required this.height,
    required this.lable,
    required this.value,
    required this.img,
    required this.isText,
  });

  final double width;
  final double height;
  final bool isText;
  final String lable;
  final String value;
  final String img;

  @override
  ConsumerState<CustomDetailContainer> createState() =>
      _CustomDetailContainerState();
}

class _CustomDetailContainerState extends ConsumerState<CustomDetailContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height * 0.1,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Config.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Config.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Container(
              width: widget.height * 0.065,
              height: widget.height * 0.065,
              decoration: BoxDecoration(
                color: Config.theme,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.asset(
                widget.img,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.lable,
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(
                              color: widget.lable ==
                                      "* Enter mileage reading or 0 if N/A to start report"
                                  ? Config.theme
                                  : Config.black,
                              fontSize: widget.width / 35,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Config.underLine))),
                      child: widget.isText
                          ? TextFormField(
                              onTapOutside: (value) {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                              },
                              onChanged: (e) {
                                print(e);
                                ref.read(milage.notifier).update((state) => e);

                                print(ref.watch(milage));
                              },

                              keyboardType: TextInputType.number,

                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Config.bg,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Config.white),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Config.white),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              // minLines: widget.lable == "Brief Statement" ? 3 : 1,
                              maxLines: 1,
                            )
                          : Text(
                              widget.value,
                              style: GoogleFonts.mulish(
                                textStyle: TextStyle(
                                    color: Config.black,
                                    fontSize: widget.width / 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
