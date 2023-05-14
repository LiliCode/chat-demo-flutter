import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/home/pages/home_page.dart';
import 'package:flutter_chat_demo/tools/web_socket/web_socket_prodiver.dart';
import 'package:flutter_chat_demo/user/controllers/user_controller.dart';
import 'package:flutter_chat_demo/user/pages/user_page.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  final List<Widget> _pages = [
    const HomePage(),
    const UserPage(),
  ];

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '主页',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_outlined),
                label: '我的',
              ),
            ],
            onTap: controller.changeIndex,
          ),
        );
      },
    );
  }
}

class MainPageController extends GetxController {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  @override
  void onInit() {
    super.onInit();

    // 全局监听 socket 的错误
    WebSocketProvider.shared.addListener(onDone: _onDone, onError: _onError);
  }

  void _onDone() {
    print('Socket 完成');
    WebSocketProvider.shared.close();
  }

  void _onError(dynamic error) {
    print('Socket 连接错误: $error');
    WebSocketProvider.shared.close();
  }

  @override
  void onClose() {
    WebSocketProvider.shared.removeDoneListener(_onDone);
    WebSocketProvider.shared.removeErrorListener(_onError);
    super.onClose();
  }

  void changeIndex(int index) {
    _currentIndex = index;
    update();
  }
}

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageController());
  }
}
