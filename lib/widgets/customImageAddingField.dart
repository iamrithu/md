import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../config/config.dart';
import '../provider/provider.dart';
import 'globalButtonWidget.dart';

class CustomImageAddingField extends ConsumerStatefulWidget {
  const CustomImageAddingField({
    Key? key,
    required this.type,
    required this.lable,
    required this.dataList,
  }) : super(key: key);

  final String type;
  final String lable;
  final List<Map<String, dynamic>> dataList;

  @override
  _CustomImageAddingFieldState createState() => _CustomImageAddingFieldState();
}

class _CustomImageAddingFieldState
    extends ConsumerState<CustomImageAddingField> {
  List<File> images = [];
  List<Map<String, dynamic>> dataList = [];
  String comment = "Good";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.dataList.isEmpty) return;

    setState(() {
      dataList = widget.dataList;
    });

    try {
      Map<String, dynamic> object =
          dataList.firstWhere((e) => e["name"] == widget.lable);

      setState(() {
        images = object["image"];
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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

    return AlertDialog(
      elevation: 10,
      backgroundColor: Config.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        widget.type == "visual_check" ? "Visual Check" : widget.type,
        style: GoogleFonts.mulish(
          textStyle: TextStyle(
              color: Config.theme,
              fontSize: width / 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
        width: width,
        height: height,
        constraints: BoxConstraints(minHeight: height * 0.5),
        child: Column(
          children: <Widget>[
            Container(
              width: width,
              height: height * 0.04,
              child: Row(
                children: [
                  Text(
                    '${widget.lable} : Images',
                    style: GoogleFonts.mulish(
                      textStyle: TextStyle(
                          color: Config.black,
                          fontSize: width / 30,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Config.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Config.underLine),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (images.isEmpty)
                        Container(
                          height: height * 0.7,
                          alignment: Alignment.center,
                          child: Wrap(
                            children: [
                              Text(
                                "Please add image",
                                style: GoogleFonts.mulish(
                                  textStyle: TextStyle(
                                      color: Color.fromARGB(255, 246, 92, 105),
                                      fontSize: width / 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (images.isNotEmpty)
                        for (var i = 0; i < images.length; i++)
                          Container(
                            width: width,
                            height: height * 0.17,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Config.white),
                            ),
                            child: Stack(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Config.white)),
                                  elevation: 10,
                                  child: Container(
                                    width: width,
                                    height: height * 0.17,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        images[i],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width,
                                  height: height * 0.17,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   border: Border.all(color: Config.white),
                                  // ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              images.remove(images[i]);
                                            });
                                            reloadProvider(dataList);
                                          },
                                          child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.delete,
                                                color: Config.theme,
                                                size: width / 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              height: height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    boderColor: Config.white,
                    radius: 4,
                    txtColor: Config.theme,
                    bgColor: Config.bg,
                    click: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.image,
                      );

                      if (result != null) {
                        List<File> files =
                            result.paths.map((path) => File(path!)).toList();

                        for (var i = 0; i < files.length; i++) {
                          setState(() {
                            images.add(files[i]);
                          });
                        }
                        if (dataList.isEmpty) {
                          dataList.add({
                            "type": widget.type,
                            "name": widget.lable,
                            "comment": comment,
                            "status": true,
                            "image": images
                          });
                        }

                        try {
                          Map<String, dynamic> object = dataList
                              .firstWhere((e) => e["name"] == widget.lable);
                          object["image"] = images;
                        } catch (e) {
                          dataList.add({
                            "type": widget.type,
                            "name": widget.lable,
                            "comment": comment,
                            "status": true,
                            "image": images
                          });
                        }

                        reloadProvider(dataList);
                      } else {
                        // User canceled the picker
                      }
                    },
                    width: width * 0.3,
                    height: height * 0.07,
                    lable: "Gallary",
                  ),
                  CustomButton(
                    boderColor: Config.white,
                    radius: 4,
                    txtColor: Config.theme,
                    bgColor: Config.bg,
                    click: () async {
                      final ImagePicker _picker = ImagePicker();

                      try {
                        final image = await _picker.pickImage(
                            source: ImageSource.camera,
                            imageQuality: 2,
                            preferredCameraDevice: CameraDevice.rear);

                        if (image == null)
                          return customAlert(
                              context: context,
                              height: height,
                              width: width,
                              content: "your camera image is null",
                              success: false);
                        ;
                        File imageTemporay = File(image.path);

                        setState(() {
                          images.add(imageTemporay);
                        });
                        if (dataList.isEmpty) {
                          dataList.add({
                            "type": widget.type,
                            "name": widget.lable,
                            "comment": comment,
                            "status": true,
                            "image": images
                          });
                        }

                        try {
                          Map<String, dynamic> object = dataList
                              .firstWhere((e) => e["name"] == widget.lable);
                          object["image"] = images;
                        } catch (e) {
                          dataList.add({
                            "type": widget.type,
                            "name": widget.lable,
                            "comment": comment,
                            "status": true,
                            "image": images
                          });
                        }

                        reloadProvider(dataList);
                      } on PlatformException catch (e) {
                        print("Failed to pick image : $e");
                      }
                      // Navigator.pop(context);
                    },
                    width: width * 0.3,
                    height: height * 0.07,
                    lable: "Camera",
                  ),
                ],
              ),
            ),
            CustomButton(
              boderColor: Config.white,
              radius: 4,
              txtColor: Config.white,
              bgColor: Config.theme,
              click: () {
                Navigator.pop(context);
              },
              width: width,
              height: height * 0.07,
              lable: "Next",
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
