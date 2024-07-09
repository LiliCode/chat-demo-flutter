import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/routes/routes.dart';
import 'package:flutter_chat_demo/login/controllers/login_controller.dart';
import 'package:flutter_chat_demo/components/loading_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_builder_wrapper/getx_widget.dart';
import 'package:oktoast/oktoast.dart';

/// 登陆页面
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登陆'),
      ),
      body: GetBuilderWidget<LoginController>(
        builder: (context, controller) => Center(
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
                  obscureText: true, // 密文展示
                  clearButtonMode: OverlayVisibilityMode.editing,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 100.w,
                  height: 40.h,
                  child: Obx(
                    () => LoadingButton(
                      title: '登陆',
                      loadingText: '登陆中',
                      radius: 40.r,
                      loading: controller.loading.value,
                      onTap: () async {
                        // 登陆
                        final result = await controller.login();
                        if (!result.$1 && result.$2 != null) {
                          showToast(result.$2!);
                        } else {
                          showToast('登陆成功');
                          // 进入主页
                          Get.offAllNamed(Routes.main);
                        }
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
                    width: 100.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(40.r)),
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
      ),
    );
  }
}
