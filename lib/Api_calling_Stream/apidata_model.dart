// To parse this JSON data, do
//
//     final apiDataModel = apiDataModelFromJson(jsonString);

import 'dart:convert';

List<ApiDataModel> apiDataModelFromJson(String str) => List<ApiDataModel>.from(
    json.decode(str).map((x) => ApiDataModel.fromJson(x)));

String apiDataModelToJson(List<ApiDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiDataModel {
  ApiDataModel({
    this.seriesname,
    this.seriesid,
    this.startdate,
    this.enddate,
  });

  String? seriesname;
  int? seriesid;
  String? startdate;
  String? enddate;

  factory ApiDataModel.fromJson(Map<String, dynamic> json) => ApiDataModel(
        seriesname: json["seriesname"],
        seriesid: json["seriesid"],
        startdate: json["startdate"],
        enddate: json["enddate"],
      );

  Map<String, dynamic> toJson() => {
        "seriesname": seriesname,
        "seriesid": seriesid,
        "startdate": startdate,
        "enddate": enddate,
      };
}
