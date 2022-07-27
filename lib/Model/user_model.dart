// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.queryStatistics,
    this.totalPages,
    this.currentPageIndex,
    this.totalRecords,
    this.returnedRecords,
    this.items,
  });

  QueryStatistics? queryStatistics;
  int? totalPages;
  int? currentPageIndex;
  int? totalRecords;
  int? returnedRecords;
  List<Item>? items;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        queryStatistics: json["queryStatistics"] == null ? null : QueryStatistics.fromJson(json["queryStatistics"]),
        totalPages: json["totalPages"] == null ? null : json["totalPages"],
        currentPageIndex: json["currentPageIndex"] == null ? null : json["currentPageIndex"],
        totalRecords: json["totalRecords"] == null ? null : json["totalRecords"],
        returnedRecords: json["returnedRecords"] == null ? null : json["returnedRecords"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "queryStatistics": queryStatistics == null ? null : queryStatistics?.toJson(),
        "totalPages": totalPages == null ? null : totalPages,
        "currentPageIndex": currentPageIndex == null ? null : currentPageIndex,
        "totalRecords": totalRecords == null ? null : totalRecords,
        "returnedRecords": returnedRecords == null ? null : returnedRecords,
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.title,
    this.isTrusted,
    this.type,
    this.description,
    this.thumbnailUrl,
    this.entityId,
    this.referenceCount,
  });

  String? title;
  bool? isTrusted;
  int? type;
  String? description;
  dynamic thumbnailUrl;
  String? entityId;
  dynamic referenceCount;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"] == null ? null : json["title"],
        isTrusted: json["isTrusted"] == null ? null : json["isTrusted"],
        type: json["type"].toString() == null ? null : json["type"],
        description: json["description"] == null ? null : json["description"],
        thumbnailUrl: json["thumbnailUrl"],
        entityId: json["entityId"] == null ? null : json["entityId"],
        referenceCount: json["referenceCount"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "isTrusted": isTrusted == null ? null : isTrusted,
        "type": type == null ? null : type,
        "description": description == null ? null : description,
        "thumbnailUrl": thumbnailUrl,
        "entityId": entityId == null ? null : entityId,
        "referenceCount": referenceCount,
      };
}

class QueryStatistics {
  QueryStatistics();

  factory QueryStatistics.fromJson(Map<String, dynamic> json) => QueryStatistics();

  Map<String, dynamic> toJson() => {};
}
