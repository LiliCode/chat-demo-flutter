import 'package:flutter_chat_demo/home/controllers/home_controller.dart';
import 'package:flutter_chat_demo/main/controllers/main_controller.dart';
import 'package:flutter_chat_demo/user/controllers/user_controller.dart';
import 'package:get/get.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => UserController());
  }
}
