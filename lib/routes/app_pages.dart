import 'package:flutter_chat_demo/init/pages/host_page.dart';
import 'package:flutter_chat_demo/login/controllers/register_controller.dart';
import 'package:flutter_chat_demo/login/pages/login_page.dart';
import 'package:flutter_chat_demo/login/pages/register_page.dart';
import 'package:flutter_chat_demo/main/bindings/main_bindings.dart';
import 'package:flutter_chat_demo/main/pages/main_page.dart';
import 'package:flutter_chat_demo/message/bindings/message_binding.dart';
import 'package:flutter_chat_demo/message/pages/message_page.dart';
import 'package:flutter_chat_demo/routes/routes.dart';
import 'package:flutter_chat_demo/login/controllers/login_controller.dart';
import 'package:get/get.dart';

/// app 页面的路由
abstract class AppPages {
  static String initPage = Routes.main;
  static String loginPage = Routes.login;
  static String hostPage = Routes.hostList;

  static List<GetPage> pages = [
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: Routes.hostList,
      page: () => const HostPage(),
    ),
    GetPage(
      name: Routes.message,
      page: () => const MessagePage(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
  ];
}
