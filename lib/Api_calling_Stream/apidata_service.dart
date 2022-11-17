import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:post_api_demo/Helper/exception_handler.dart';

class ApiDataService {
  static final ApiDataService _networkAPICall = ApiDataService._internal();

  factory ApiDataService() {
    return _networkAPICall;
  }

  ApiDataService._internal();

  Future<dynamic> get(String url, {Map<String, String>? header}) async {
    var client = http.Client();

    //final headers = {"Authorization": "Bearer"};
    try {
      final response = await client.get(Uri.parse(url));

      return checkResponse(response);
    } catch (e) {
      log("Get Api Error--->$e");
      client.close();
      rethrow;
    }
  }

  dynamic checkResponse(http.Response response) {
    try {
      switch (response.statusCode) {
        case 200:
          try {
            if (response.body.isEmpty) {
              throw AppException(
                  message: 'Response body is empty', errorCode: 0);
            }
            print("responce body=====${response.body}");

            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }
        default:
          try {
            if (response.body.isEmpty) {
              throw AppException(
                  message: 'Response body is empty',
                  errorCode: response.statusCode);
            }
            jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }
      }
    } catch (e) {
      rethrow;
    }
  }
}
