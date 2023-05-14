import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/routes/routes.dart';
import 'package:flutter_chat_demo/user/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户'),
      ),
      body: GetBuilder<UserController>(
        builder: (controller) {
          return controller.isLogin
              ? Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: controller.user.avatar ?? '',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${controller.user.name}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${controller.user.account}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          controller.logout();
                          showToast('已经退出登陆');
                        },
                        child: const Text(
                          '退出登陆',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.login);
                    },
                    child: const Text(
                      '请登录',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
