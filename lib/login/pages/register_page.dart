import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/login/controllers/register_controller.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注册'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CupertinoTextField(
                placeholder: '请输入用户昵称',
                controller: controller.nameController,
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                placeholder: '请输入账号',
                controller: controller.accountController,
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                placeholder: '请输入密码',
                controller: controller.pwdController,
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                placeholder: '请再次输入密码',
                controller: controller.againPwdController,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  controller.register((p0) {
                    if (p0 == null) {
                      showToast('注册成功');
                      Get.back();
                    } else {
                      showToast(p0);
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Text(
                    '注册',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
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
