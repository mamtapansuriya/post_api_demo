import 'dart:io';

import 'package:get/get.dart';
import 'package:post_api_demo/Utils/app_string.dart';

class AppException implements Exception {
  //un_known error code -> 0

  late String message;
  String? tag;
  int errorCode;

  AppException({required this.message, required this.errorCode, this.tag});

  int getErrorCode() => errorCode;

  String getMessage() => message;

  String getMessageWithTag() => "${tag ?? AppString.noTag} : $message";

  String? getTag() => tag;

  @override
  String toString() {
    return "${errorCode.toString()} : ${tag ?? AppString.noTag} : $message";
  }

  static dynamic showException(dynamic exception, [dynamic stackTrace]) {
    if (exception is AppException) {
      exception.show();
    } else if (exception is SocketException) {
      AppException(message: exception.message, errorCode: exception.osError?.errorCode ?? 0).show();
    } else if (exception is HttpException) {
      AppException(message: AppString.couldNotFindTheRequestedData, errorCode: 0).show();
    } else if (exception is FormatException) {
      AppException(message: AppString.badResponseFormat, errorCode: 0).show();
    } else {
      AppException(message: AppString.somethingWentWrong, errorCode: 0).show();
    }
  }

  void show() {
    //AppSnackBar.showErrorSnackBar(message: message, title: AppString.error);
    Get.snackbar(AppString.error, message);
  }
}
