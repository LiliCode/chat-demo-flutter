import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/configs/host_manager.dart';
import 'package:flutter_chat_demo/home/controllers/home_controller.dart';
import 'package:flutter_chat_demo/posts/controllers/post_list_controller.dart';
import 'package:flutter_chat_demo/routes/app_pages.dart';
import 'package:flutter_chat_demo/routes/routes.dart';
import 'package:flutter_chat_demo/tools/net_service/net_provider.dart';
import 'package:flutter_chat_demo/user/controllers/user_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  // 初始化持久化
  await GetStorage.init();
  // 依赖注入
  Get.lazyPut(() => UserController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => PostListController());

  // 读取 ip
  if (HostManager().firstHost != null) {
    NetProvider().init(HostManager().firstHost!, kDebugMode);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final initPage =
        HostManager().hosts.isNotEmpty ? AppPages.initPage : AppPages.hostPage;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      rebuildFactor: (old, data) => old != data,
      child: OKToast(
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
          defaultTransition: Transition.cupertino, // 默认转场方式 iOS 风格
          initialRoute: initPage,
          getPages: AppPages.pages,
          navigatorObservers: [Routes.routeObserver],
        ),
      ),
    );
  }
}
