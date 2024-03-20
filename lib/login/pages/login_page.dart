import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/routes/routes.dart';
import 'package:flutter_chat_demo/user/controllers/user_controller.dart';
import 'package:flutter_chat_demo/components/loading_button.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends GetView<UserController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登陆'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
          child: Column(
            children: [
              CupertinoTextField(
                placeholder: '请输入账号...',
                controller: controller.accountController,
                clearButtonMode: OverlayVisibilityMode.editing,
              ),
              const SizedBox(height: 15),
              CupertinoTextField(
                placeholder: '请输入密码...',
                controller: controller.pwdController,
                keyboardType: TextInputType.visiblePassword,
                clearButtonMode: OverlayVisibilityMode.editing,
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 100,
                height: 30,
                child: GetBuilder<UserController>(
                  builder: (controller) => LoadingButton(
                    title: '登陆',
                    loadingText: '登陆中',
                    radius: 17.5,
                    loading: controller.loading,
                    onTap: () {
                      // 登陆
                      controller.login((msg) {
                        if (msg != null) {
                          showToast(msg);
                        } else {
                          showToast('登陆成功');
                          Get.back();
                        }
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.register);
                },
                child: Container(
                  width: 100,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17.5)),
                  ),
                  child: const Center(
                    child: Text(
                      '注册',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
