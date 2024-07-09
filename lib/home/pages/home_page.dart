import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/home/controllers/home_controller.dart';
import 'package:flutter_chat_demo/home/pages/drawer_page.dart';
import 'package:flutter_chat_demo/home/widgets/chat_list_tile.dart';
import 'package:flutter_chat_demo/routes/routes.dart';
import 'package:flutter_chat_demo/login/controllers/login_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_builder_wrapper/getx_widget.dart';
import 'package:oktoast/oktoast.dart';

/// 主页面
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
        title: Text(
          '聊天',
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
      ),
      drawer: const Drawer(
        child: DrawerPage(),
      ),
      body: GetBuilderListWidget<HomeController>(
        builder: (context, controller) => ListView.separated(
          itemCount: controller.dataSource.length,
          itemBuilder: (context, index) => ChatListTile(
            onTap: () {
              // 聊天
              Get.toNamed(
                Routes.message,
                arguments: controller.dataSource[index],
              );
            },
            user: controller.dataSource[index],
          ),
          separatorBuilder: (context, index) => Divider(
            indent: 70.w,
            height: 5.h,
            thickness: 0.5,
            color: Colors.black12,
          ),
        ),
      ),
    );
  }
}
