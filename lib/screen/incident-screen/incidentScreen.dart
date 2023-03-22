// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:md/config/config.dart';
import 'package:md/screen/driver-screen/driverScreen.dart';
import 'package:md/screen/report-screen/reportScreen.dart';
import 'package:md/widgets/globalButtonWidget.dart';

import '../../api/api.dart';
import '../../provider/provider.dart';
import '../login-screen/widget/customTextForm.dart';

class IncidentScreen extends ConsumerStatefulWidget {
  const IncidentScreen({Key? key}) : super(key: key);

  @override
  _IncidentScreenState createState() => _IncidentScreenState();
}

List<File> images = [];

class _IncidentScreenState extends ConsumerState<IncidentScreen> {
  DateTime date = DateTime.now();
  bool isLoading = false;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _witnessController = TextEditingController();
  final TextEditingController _statementController = TextEditingController();

  final TextEditingController _witnessNumberController =
      TextEditingController();

  bool isRememberMe = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      images = ref.read(incidentProvider)["image"];
    });
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
    Future<bool> _handleLocationPermission() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
        return false;
      }
      return true;
    }

    Future<void> _getAddressFromLatLng(Position position) async {
      await placemarkFromCoordinates(position.latitude, position.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];

        print(place.toString());
        setState(() {
          _locationController.text =
              '${place.street} ${place.subAdministrativeArea}  ${place.subLocality}  ${place.locality} ${place.administrativeArea} ${place.postalCode}';
          isLoading = false;
        });
      }).catchError((e) {
        debugPrint(e);
      });
    }

    Future<void> _getCurrentPosition() async {
      final hasPermission = await _handleLocationPermission();

      if (!hasPermission) return;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        _getAddressFromLatLng(position);
      }).catchError((e) {
        debugPrint(e);
      });
    }

    IncidentScreen() {
      Map<String, dynamic> object = {
        "date": "${DateFormat("dd-MM-yyyy").format(date)}",
        "location": _locationController.text,
        "witnessed_by": _witnessController.text,
        "mobile": _witnessNumberController.text,
        "statement": _statementController.text.isEmpty
            ? "--"
            : _statementController.text,
      };
      if (object["location"].isEmpty) {
        return customAlert(
          context: context,
          height: height,
          width: width,
          content: "Must include location name",
          success: false,
        );
      }
      if (object["witnessed_by"].isEmpty) {
        return customAlert(
          context: context,
          height: height,
          width: width,
          content: "Must include  Witnessed by",
          success: false,
        );
      }
      if (object["mobile"].isEmpty) {
        return customAlert(
          context: context,
          height: height,
          width: width,
          content: "Must include Witness Number",
          success: false,
        );
      }
      if (images.isEmpty) {
        return customAlert(
          context: context,
          height: height,
          width: width,
          content: "Must include Image Proof",
          success: false,
        );
      }

      ref.read(incidentProvider.notifier).update((state) {
        return object;
      });

      Api()
          .incident(ref.watch(token), ref.watch(assignDetailProvider)[0]["id"],
              object, images)
          .then((value) {
        if (value.statusCode != 200) {
          return customAlert(
            context: context,
            height: height,
            width: width,
            content: "Something went wrong ....",
            success: false,
          );
        }
      });
      customAlert(
        context: context,
        height: height,
        width: width,
        content: "Data Stored Successfully",
        success: true,
      );
      final data = ref.refresh(incidentProvider);
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
          child: Stack(
            children: [
              Container(
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
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20, right: 20),
                        child: ListView(
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
                              height: 15,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Location",
                                      style: GoogleFonts.mulish(
                                        textStyle: TextStyle(
                                            color: Config.black,
                                            fontSize: width / 26,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () {
                                        setState(() {
                                          _locationController.text = "";
                                          isLoading = true;
                                        });
                                        _getCurrentPosition();
                                      },
                                      child: Card(
                                        elevation: 5,
                                        color: Config.theme,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.location_pin,
                                              color: Config.white,
                                              weight: width / 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  onTapOutside: (value) {
                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.hide');
                                  },
                                  controller: _locationController,
                                  keyboardType: TextInputType.text,
                                  obscureText: false,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Config.white,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.0, 10.0, 10.0, 10.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Config.white),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Config.white),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  // minLines: widget.lable == "Brief Statement" ? 3 : 1,
                                  maxLines: 3,
                                )
                              ],
                            ),
                            // IconButton(
                            //   onPressed: () {

                            //     // showDialog<void>(
                            //     //   context: context,
                            //     //   barrierDismissible: true, // user must tap button!
                            //     //   builder: (BuildContext context) {
                            //     //     return LocationPage();
                            //     //   },
                            //     // );
                            //   },
                            //   icon: Icon(Icons.location_city),
                            // ),
                            // CustomTextForm(
                            //   hide: false,
                            //   width: width * 0.1,
                            //   controller: _locationController,
                            //   lable: "",
                            // ),
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
                            Container(
                              width: width,
                              height: height * 0.05,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomButton(
                                    boderColor: Config.white,
                                    radius: 4,
                                    txtColor: Config.white,
                                    bgColor: Config.theme,
                                    click: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform
                                              .pickFiles(allowMultiple: true);

                                      if (result != null) {
                                        List<File> files = result.paths
                                            .map((path) => File(path!))
                                            .toList();

                                        for (var i = 0; i < files.length; i++) {
                                          setState(() {
                                            images.add(files[i]);
                                          });
                                        }
                                      } else {
                                        // User canceled the picker
                                      }
                                    },
                                    width: width * 0.4,
                                    height: height * 0.07,
                                    lable: "Gallary",
                                  ),
                                  CustomButton(
                                    boderColor: Config.white,
                                    radius: 4,
                                    txtColor: Config.white,
                                    bgColor: Config.theme,
                                    click: () async {
                                      final ImagePicker _picker = ImagePicker();

                                      try {
                                        final image = await _picker.pickImage(
                                            source: ImageSource.camera,
                                            preferredCameraDevice:
                                                CameraDevice.rear);

                                        if (image == null)
                                          return customAlert(
                                              context: context,
                                              height: height,
                                              width: width,
                                              content:
                                                  "your camera image is null",
                                              success: false);
                                        ;
                                        File imageTemporay = File(image.path);
                                        setState(() {
                                          images.add(imageTemporay);
                                        });
                                      } on PlatformException catch (e) {
                                        print("Failed to pick image : $e");
                                      }
                                      // Navigator.pop(context);
                                    },
                                    width: width * 0.4,
                                    height: height * 0.07,
                                    lable: "Camera",
                                  ),
                                ],
                              ),
                            ),
                            if (images.isNotEmpty)
                              Container(
                                width: width,
                                height: height * 0.2,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    for (var i = 0; i < images.length; i++)
                                      Container(
                                        width: width * 0.4,
                                        height: height * 0.17,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Config.theme),
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: width,
                                              height: height * 0.17,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Config.white),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  images[i],
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: width,
                                              height: height * 0.17,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Config.white),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        images
                                                            .remove(images[i]);
                                                      });
                                                    },
                                                    child: Card(
                                                      elevation: 10,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
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
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
              if (isLoading)
                Container(
                  width: width,
                  height: height,
                  color: Color.fromARGB(87, 255, 241, 250),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
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
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000)),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Getting Location ...",
                            style: GoogleFonts.mulish(
                              textStyle: TextStyle(
                                  color: Config.theme,
                                  fontSize: width / 30,
                                  fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
