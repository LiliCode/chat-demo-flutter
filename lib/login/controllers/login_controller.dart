import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/common/login_manager.dart';
import 'package:get/get.dart';
import 'package:getx_builder_wrapper/base_controller.dart';

/// 登陆页面
class LoginController extends BaseGetxController {
  bool get isLogin => LoginManager().isLogin;
  final loading = false.obs;

  final accountController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    request();
  }

  @override
  Future<void> request() async {
    updateSuccess();
  }

  @override
  void onClose() {
    accountController.dispose();
    pwdController.dispose();
    super.onClose();
  }

  /// 登陆
  Future<(bool, String?)> login() async {
    if (accountController.text.isEmpty || pwdController.text.isEmpty) {
      return (false, '请输入账号或者密码');
    }

    // 开始加载
    loading.value = true;
    // 登陆
    final result =
        await LoginManager().login(accountController.text, pwdController.text);

    loading.value = false;

    return result;
  }

  void logout() => LoginManager().logout();
}
