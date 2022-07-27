import 'dart:convert';
import 'dart:developer';

import 'package:post_api_demo/Helper/network_helper.dart';
import 'package:post_api_demo/Model/user_model.dart';

class UserService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<UserModel> userPostData(int index, String str) async {
    try {
      log("page no in userPostData>>>>>>>>>>>>>>>>>>>${index}");
      log("page no in str>>>>>>>>>>>>>>>>>>>${str}");
      Map<String, dynamic> body = {"pageIndex": index, "searchText": str, "returnedRecords": 20};
      log("============called userPostData");
      final response = await _networkAPICall.post("search", body: jsonEncode(body), header: {"Content-Type": "application/json"});

      print(">>>>>>>>>>>>>>>>>>>>>>>>>>");
      return UserModel.fromJson(response);
    } catch (exception) {
      log("error in userpostdata========$exception");
      rethrow;
    }
  }
}
