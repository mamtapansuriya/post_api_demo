import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:post_api_demo/Utils/app_string.dart';

import 'exception_handler.dart';

class NetworkAPICall {
  static final NetworkAPICall _networkAPICall = NetworkAPICall._internal();

  factory NetworkAPICall() {
    return _networkAPICall;
  }

  NetworkAPICall._internal();

  // Future<dynamic> get(String url, {Map<String, String>? header}) async {
  //   var client = http.Client();
  //
  //   //final headers = {"Authorization": "Bearer"};
  //   try {
  //     final String fullURL = AppString.baseUrl + url;
  //     final response = await client.get(Uri.parse(fullURL));
  //     log("Get Api Url ===> $fullURL");
  //     //log("Get Api  Header ===> ${header ?? headers}");
  //     // log("Get Api StatusCode ===> ${response.statusCode}");
  //     return checkResponse(response);
  //   } catch (e) {
  //     log("Get Api Error--->$e");
  //     client.close();
  //     rethrow;
  //   }
  // }

  Future<dynamic> post(String url, {Map<String, String>? header, dynamic body}) async {
    var client = http.Client();
    try {
      final String fullURL = AppString.baseUrl + url;
      final response = await client.post(Uri.parse(fullURL), body: body, headers: header);

      //log("Post Api Response ===> ${response.body}");
      return checkResponse(response);
    } catch (e) {
      log("Post Api Error--->$e");
      client.close();
      rethrow;
    }
  }

  // Future delete({required String url}) async {
  //   try {
  //     String? token1 = await SharedPrefs.getUser();
  //     final header = {"Authorization": "Bearer $token1"};
  //     final response = await dio.delete(Uri.parse(url), headers: header);
  //     log("Delete Api Url ===> $url");
  //     log("Delete Api  Header ===> ${response.headers}");
  //     log("Delete Api StatusCode ===> ${response.statusCode}");
  //     return response;
  //   } catch (e) {
  //     log("Delete Api Error ===> $e");
  //     dio.close();
  //     rethrow;
  //   }
  // }
  //
  // Future<dynamic> put(String url, {Map<String, String>? header, dynamic body}) async {
  //   try {
  //     final String fullURL = baseUrl + url;
  //     final response = await dio.put(Uri.parse(fullURL), headers: header);
  //     log("Put Api Url ===> $fullURL");
  //     log("Put Api  Header ===> $header");
  //     log("Put Api StatusCode ===> ${response.statusCode}");
  //     return response;
  //   } catch (e) {
  //     log("Put Api Error ===> $e");
  //     dio.close();
  //     rethrow;
  //   }
  // }

  dynamic checkResponse(http.Response response) {
    try {
      switch (response.statusCode) {
        case 200:
          try {
            if (response.body.isEmpty) {
              throw AppException(message: 'Response body is empty', errorCode: 0);
            }
            print("responce body=====${response.body}");

            return jsonDecode(response.body);
          } catch (e) {
            rethrow;
          }
        default:
          try {
            if (response.body.isEmpty) {
              throw AppException(message: 'Response body is empty', errorCode: response.statusCode);
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
