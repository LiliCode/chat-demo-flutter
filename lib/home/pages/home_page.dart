import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/home/controllers/home_controller.dart';
import 'package:flutter_chat_demo/routes/routes.dart';
import 'package:flutter_chat_demo/user/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 订阅路由事件
    Routes.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    // 取消订阅
    Routes.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    print('didPopNext');
  }

  @override
  void didPushNext() {
    super.didPushNext();
    print('didPushNext');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('联系人'),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return RefreshIndicator(
            child: ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (context, index) => ListTile(
                leading: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: controller.list[index].avatar ?? '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(controller.list[index].name ?? '无名氏'),
                subtitle: Text(controller.list[index].account ?? '无账号'),
                trailing: IconButton(
                  onPressed: () {
                    if (Get.find<UserController>().isLogin) {
                      Get.toNamed(
                        Routes.message,
                        arguments: controller.list[index],
                      );
                    } else {
                      showToast('您还为登陆账号, 暂时不能和对方聊天');
                    }
                  },
                  icon: const Icon(
                    Icons.message,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            onRefresh: () => controller.refreshData(),
          );
        },
      ),
    );
  }
}
