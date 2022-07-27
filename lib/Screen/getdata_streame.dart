import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_api_demo/Controller/userdata_controller.dart';
import 'package:post_api_demo/Model/user_model.dart';
import 'package:sizer/sizer.dart';

class StreamHomePage extends StatefulWidget {
  StreamHomePage({Key? key}) : super(key: key);

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  final UserController _userController = Get.find();

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Search Data Using Stream"),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            TextFormField(
              onChanged: (String? value) async {
                if (value!.isNotEmpty && value.length > 0) {
                  _userController.searchString.value = value;
                  _userController.userList.clear();
                  _userController.page.value = 0;

                  setState(() {
                    _userController.getDataStream();
                  });
                  // if (_debounce?.isActive ?? false) _debounce!.cancel();
                  // _debounce = Timer(const Duration(milliseconds: 10), () {
                  //   _userController.getDataStream();
                  //   // _userController.loadUser();
                  // });

                  // _userController.postData();
                } else {
                  _userController.searchString.value = value;
                }
              },
              keyboardType: TextInputType.name,
              // controller: _userController.searchName,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3.w))),
                filled: true,
                hintText: "Search Name",
              ),
              validator: (value) {
                String patttern = '[a-zA-Z]';
                if (value!.isEmpty || !RegExp(patttern).hasMatch(value)) {
                  return 'Please Enter valid Name';
                }
                return null;
              },
            ),
            Expanded(
                child: StreamBuilder<List<Item>>(
              stream: _userController.getDataStream(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    controller: _userController.scrollController,
                    itemCount: _userController.userList.length,
                    itemBuilder: (context, index) {
                      var data = _userController.userList[index];
                      return ListTile(
                          title: Text(data.title.toString()),
                          leading: CircleAvatar(
                            radius: 5.w,
                            child: Image.network(data.thumbnailUrl ??
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_upzZ7ljAZIdBCo1AL1A3BPA5i_b2K1HI4w&usqp=CAU"),
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(">>>>>>>>>>>>>>>>${snapshot.error}");
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
            Obx(() => _userController.isLoading.value
                ? SizedBox(
                    height: 8.h,
                    width: 100.w,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _userController.showFirst(_userController.page.value);
        },
        child: const Icon(Icons.swap_vert),
      ),
    ));
  }
}
