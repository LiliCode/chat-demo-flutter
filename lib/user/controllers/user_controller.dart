import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/home/controllers/home_controller.dart';
import 'package:flutter_chat_demo/tools/net_service/net_provider.dart';
import 'package:flutter_chat_demo/tools/web_socket/web_socket_prodiver.dart';
import 'package:flutter_chat_demo/user/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

class UserController extends GetxController {
  User user = User();
  bool get isLogin => user.account != null && user.id != null;
  bool _loading = false;
  bool get loading => _loading;

  final accountController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    // 判断是否登陆, 获取用户信息
    final prefers = GetStorage();
    final loginInfo = prefers.read('LoginKey');
    if (loginInfo != null && loginInfo.isNotEmpty) {
      final info = json.decode(loginInfo) as Map<String, dynamic>;
      user = User.fromJson(info);
      // 刷新UI
      update();

      // 连接 socket
      connectSocket(user.id);
    }
  }

  @override
  void onClose() {
    accountController.dispose();
    pwdController.dispose();
    super.onClose();
  }

  // 连接 socket
  void connectSocket(int? id) => WebSocketProvider.shared.connect(id: id);

  // 断开 socket
  void disconnectSocket() => WebSocketProvider.shared.close();

  /// 登陆
  void login(void Function(String?)? callback) async {
    if (accountController.text.isEmpty || pwdController.text.isEmpty) {
      showToast('请输入账号或者密码');
      return;
    }

    // 开始加载
    _loading = true;
    update();
    final res = await NetProvider.post<Map<String, dynamic>>(
      Api.login,
      data: {'account': accountController.text, 'password': pwdController.text},
    );
    if (res.status == NetStatus.success && res.content != null) {
      // 保存用户信息
      final prefers = GetStorage();
      prefers.write('LoginKey', json.encode(res.content));
      user = User.fromJson(res.content!);
      // 加载完成
      _loading = false;
      // 刷新状态
      update();
      // 连接 socket
      connectSocket(user.id);
      // 刷新首页列表，去掉自己
      Get.find<HomeController>().refreshData();
      if (callback != null) {
        callback(null);
      }
    } else {
      if (callback != null) {
        callback(res.description ?? '错误');
      }
    }
  }

  void logout() {
    final prefers = GetStorage();
    prefers.write('LoginKey', '');
    user = User();
    update();
    // 断开 socket
    disconnectSocket();
  }
}
