import 'dart:developer';

import 'package:post_api_demo/Api_calling_Stream/apidata_model.dart';
import 'package:post_api_demo/Api_calling_Stream/apidata_service.dart';
import 'package:rxdart/rxdart.dart';

class ApiDataStream {
  static final ApiDataStream _liveStream = ApiDataStream.init();

  factory ApiDataStream() {
    return _liveStream;
  }
  ApiDataStream.init();
  ApiDataService apiDataService = ApiDataService();

  final _apiDataStream1 = PublishSubject<List<ApiDataModel>>();

  Stream get apiDataSteam => _apiDataStream1.stream;

  Future<PublishSubject<List<ApiDataModel>>> getDataStream() async {
    try {
      List<ApiDataModel> apiDataList = [];
      const String url =
          "http://sgcricketnew.cricketfeed.co.in/api/values/LiveSeries";
      final response = await ApiDataService().get(url);
      apiDataList = apiDataModelFromJson(response.body);
      print("apiDataList length is====${apiDataList.length}");
      _apiDataStream1.add(apiDataList);
      return _apiDataStream1;
      //yield apiDataList;
    } catch (e) {
      log("Post Api Error--->$e");

      rethrow;
    }
  }
}
