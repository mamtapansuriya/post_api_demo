import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_api_demo/Helper/getmore_record.dart';
import 'package:post_api_demo/Model/user_model.dart';
import 'package:post_api_demo/Service/user_service.dart';

class UserController extends GetxController {
  Rx<UserModel> userModel = UserModel().obs;
  RxList<Item> userList = <Item>[].obs;
  //RxList<Item> searchList = <Item>[].obs;
  // TextEditingController searchName = TextEditingController();

  ScrollController scrollController = ScrollController();
  final DeBouncer _deBouncer = DeBouncer(milliseconds: 10);
  RxInt page = 0.obs;
  RxBool isValue = false.obs;
  RxString searchString = "aa".obs;
  RxBool isLoading = false.obs;
  // late StreamController<UserModel> userStreamController;

  Future postData() async {
    try {
      if (page.value == 0) {
        isValue.value = true;
      }
      log("=============page value in postData========${page.value}");
      userModel.value = await UserService.userPostData(page.value, searchString.value);

      for (var i in userModel.value.items ?? []) {
        userList.add(i);
      }
      isLoading.value = false;
      isValue.value = false;
    } catch (e) {
      isValue.value = false;
      log("error in post data======$e");
    }
  }

  // loadUser() async {
  //   postData().then((res) async {
  //     userStreamController.add(res);
  //     return res;
  //   });
  // }

  // Stream<dynamic> getDataStream() {
  //   return Stream.fromFuture(postData());
  // }
  Stream<List<Item>> getDataStream() async* {
    print("value---->${searchString.value}");
    try {
      if (page.value == 0) {
        isValue.value = true;
      }
      log(">>>>>>>>>>>>>>000000 get stream");
      userModel.value = await UserService.userPostData(page.value, searchString.value);
      for (var data in userModel.value.items ?? []) {
        userList.add(data);
      }

      isLoading.value = false;
      isValue.value = false;
      yield userList.value;
    } catch (e) {
      log("get data by stream======$e");
    }
  }

  void pagination() async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        await _deBouncer.run(() async {
          page.value++;
          isLoading.value = true;
          log("pagignation page no is  *********** ${page.value}");

          //getDataStream();
          await postData();
        });
      }
    });
  }

  showFirst(int index) async {
    try {
      scrollController.animateTo(
        index * 1,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      log("error in showfirst==========$e");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // userStreamController = StreamController();
    userList.clear();
    pagination();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
    // page.value = 0;
    // searchName.clear();
    // userList.clear();
  }
}
