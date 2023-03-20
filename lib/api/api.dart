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
      var params = {"email": email, "password": password};
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
}
