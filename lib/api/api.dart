import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../config/config.dart';

class Api {
  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(milliseconds: 30000),
      baseUrl: Config.URL,
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
    ),
  );

  Future Login(String email, String password) async {
    try {
      FormData newData =
          FormData.fromMap({"email": email, "password": password});

      Response response = await dio.post(
        "api/login",
        data: newData,
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future inspection(String token, int id, Map<String, dynamic> data) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      Response response = await dio.post(
        "api/inspection/${id}",
        data: jsonEncode(data),
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future incident(
      String token, int id, Map<String, dynamic> data, List<File> files) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      FormData newData = FormData.fromMap({
        "date": data["date"],
        "location": data["location"],
        "witnessed_by": data["witnessed_by"],
        "mobile": data["mobile"],
        "statement": data["statement"],
      });

      for (var j = 0; j < files.length; j++) {
        String fileName = files[j].path.split('/').last;
        newData.files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(
              files[j].path,
              filename: fileName,
            ),
          ),
        );
      }

      Response response = await dio.post(
        "http://vehicle.paravsoftware.co.uk/api/report/${id}",
        data: newData,
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future check(String token, String type, List<Map<String, dynamic>> datas,
      int id) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      FormData data = FormData();
      data.fields.add(MapEntry("type", type));
      for (var i = 0; i < datas.length; i++) {
        data.fields
            .add(MapEntry("name[${datas[i]["name"]}]", datas[i]["name"]));
        data.fields.add(MapEntry("notes[${datas[i]["name"]}]",
            datas[i]["comment"].isEmpty ? "--" : datas[i]["comment"]));
        data.fields.add(MapEntry("status[${datas[i]["name"]}]",
            datas[i]["status"] ? "Good" : "Bad"));
        for (var j = 0; j < datas[i]["image"].length; j++) {
          String fileName = datas[i]["image"][j].path.split('/').last;
          data.files.add(
            MapEntry(
              "image[][${datas[i]["name"]}]",
              await MultipartFile.fromFile(
                datas[i]["image"][j].path,
                filename: fileName,
              ),
            ),
          );
        }
      }
      Response response = await dio.post(
        "api/visualcheck/${id}",
        data: data,
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
