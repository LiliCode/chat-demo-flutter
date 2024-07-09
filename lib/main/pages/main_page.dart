import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/home/pages/home_page.dart';
import 'package:flutter_chat_demo/main/controllers/main_controller.dart';
import 'package:flutter_chat_demo/tools/web_socket/web_socket_prodiver.dart';
import 'package:flutter_chat_demo/user/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:getx_builder_wrapper/getx_widget.dart';

/// 主页面
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // 注册监听器，监听 App 的生命周期
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // 移除监听器
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// 连接 socket
  void _connectSocket() {
    final controller = Get.find<UserController>();
    if (controller.isLogin && !WebSocketProvider.shared.connectStatus) {
      WebSocketProvider.shared.connect(id: controller.user.id);
    }
  }

  /// 断开 socket
  void _disconnectSocket() {
    if (WebSocketProvider.shared.connectStatus) {
      WebSocketProvider.shared.close();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App 的生命周期回调
    switch (state) {
      case AppLifecycleState.inactive:
        print('app -> inactive');
        break;
      case AppLifecycleState.resumed:
        print('app -> resumed 恢复');
        // 连接
        _connectSocket();
        break;
      case AppLifecycleState.paused:
        print('app -> paused 挂起');
        break;
      case AppLifecycleState.detached:
        print('app -> detached 已经退出(进程已杀死)');
        // 关闭连接
        _disconnectSocket();
        break;
      case AppLifecycleState.hidden:
        // 关闭连接
        _disconnectSocket();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilderWidget<MainPageController>(
        builder: (context, controller) => const HomePage(),
      ),
    );
  }
}
