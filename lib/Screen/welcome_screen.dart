import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_api_demo/Routs/page_routs.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("api calling practice"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.homePage);
                },
                child: const Text("pagination api")),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.streamHomePage);
                },
                child: const Text("ApiCalling Stream Pagination")),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.apiDataScreen);
                },
                child: const Text("Api Calling Stream"))
          ],
        ),
      ),
    ));
  }
}
