import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:post_api_demo/Controller/userdata_controller.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Search Text To Find Record"),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      onChanged: (String? value) {
                        if (value!.isNotEmpty && value.length > 0) {
                          _userController.searchString.value = value;
                          _userController.userList.clear();
                          _userController.page.value = 0;
                          _userController.postData();
                        } else {
                          _userController.searchString.value = value;
                        }
                      },
                      keyboardType: TextInputType.name,
                      // controller: _userController.searchName,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.w))),
                        filled: true,
                        hintText: "Search Name",
                      ),
                      validator: (value) {
                        String patttern = '[a-zA-Z]';
                        if (value!.isEmpty ||
                            !RegExp(patttern).hasMatch(value)) {
                          return 'Please Enter valid Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  JustTheTooltip(
                    preferredDirection: AxisDirection.up,
                    child: Material(
                      color: Colors.grey.shade800,
                      shape: const CircleBorder(),
                      elevation: 4.0,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    content: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Bacon ipsum dolor amet kevin turducken brisket pastrami, salami ribeye spare ribs tri-tip sirloin shoulder venison shank burgdoggen chicken pork belly. Short loin filet mignon shoulder rump beef ribs meatball kevin.',
                      ),
                    ),
                  )
                ],
              ),
              Obx(() => _userController.isValue.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.separated(
                          controller: _userController.scrollController,
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
                            return Divider(
                              thickness: 0.w,
                              color: Colors.grey,
                            );
                          },
                          itemCount: _userController.userList.length),
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
          child: Icon(Icons.swap_vert),
        ),
      ),
    );
  }
}
