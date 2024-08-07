import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/common/colors.dart';
import 'package:flutter_chat_demo/common/login_manager.dart';
import 'package:flutter_chat_demo/configs/host_manager.dart';
import 'package:flutter_chat_demo/routes/app_pages.dart';
import 'package:flutter_chat_demo/routes/routes.dart';
import 'package:flutter_chat_demo/tools/net_service/net_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
// ignore: depend_on_referenced_packages
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

// 初始化
Future<void> init() async {
  // 初始化本地存储
  await GetStorage.init();

  // 读取 ip
  if (HostManager().firstHost != null) {
    NetProvider().init(HostManager().firstHost!, kDebugMode);
  }

  // 登陆初始化
  await LoginManager().init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final initPage = HostManager().hosts.isNotEmpty
        ? (LoginManager().isLogin ? AppPages.initPage : AppPages.loginPage)
        : AppPages.hostPage;

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
          title: 'Flutter Chat',
          theme: ThemeData(
            primarySwatch: AppColors.main.toMaterialColor(),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.main,
              foregroundColor: Colors.white,
            ),
          ),
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.cupertino, // 默认转场方式 iOS 风格
          initialRoute: initPage,
          getPages: AppPages.pages,
          navigatorObservers: [Routes.routeObserver],
          localizationsDelegates: const [
            // 刷新组件国际化
            RefreshLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh'),
            Locale('en'),
          ],
          localeListResolutionCallback: (locales, supportedLocales) {
            // 首选中文
            return const Locale('zh');
          },
        ),
      ),
    );
  }
}
