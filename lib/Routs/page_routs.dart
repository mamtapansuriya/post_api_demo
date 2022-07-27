import 'package:get/get.dart';
import 'package:post_api_demo/Screen/getdata_streame.dart';
import 'package:post_api_demo/Screen/home_page.dart';

class AppRoutes {
  static const homePage = "/homePage";
  static const streamHomePage = "/streamHomePage";

  static final pages = [
    GetPage(name: AppRoutes.homePage, page: () => HomePage()),
    GetPage(name: AppRoutes.streamHomePage, page: () => StreamHomePage()),
  ];
}
