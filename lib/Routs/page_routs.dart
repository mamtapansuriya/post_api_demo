import 'package:get/get.dart';
import 'package:post_api_demo/Api_calling_Stream/apidata_screen.dart';
import 'package:post_api_demo/Screen/getdata_streame.dart';
import 'package:post_api_demo/Screen/home_page.dart';
import 'package:post_api_demo/Screen/welcome_screen.dart';

class AppRoutes {
  static const welcomeScreen = "/welcomeScreen";
  static const homePage = "/homePage";
  static const streamHomePage = "/streamHomePage";
  static const apiDataScreen = "/apiDataScreen";

  static final pages = [
    GetPage(name: AppRoutes.welcomeScreen, page: () => WelcomeScreen()),
    GetPage(name: AppRoutes.homePage, page: () => HomePage()),
    GetPage(name: AppRoutes.streamHomePage, page: () => StreamHomePage()),
    GetPage(name: AppRoutes.apiDataScreen, page: () => ApiDataScreen()),
  ];
}
