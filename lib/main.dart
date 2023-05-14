import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/home/controllers/home_controller.dart';
import 'package:flutter_chat_demo/routes/app_pages.dart';
import 'package:flutter_chat_demo/routes/routes.dart';
import 'package:flutter_chat_demo/user/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

void main() async {
  // 初始化持久化
  await GetStorage.init();
  // 依赖注入
  Get.lazyPut(() => UserController());
  Get.lazyPut(() => HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      radius: 15,
      textPadding:
          const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
      position: ToastPosition.bottom,
      backgroundColor: Colors.black.withOpacity(0.7),
      child: GetMaterialApp(
        title: 'Chat Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initPage,
        getPages: AppPages.pages,
        navigatorObservers: [Routes.routeObserver],
      ),
    );
  }
}
