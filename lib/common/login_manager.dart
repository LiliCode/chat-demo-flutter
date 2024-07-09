import 'dart:convert';

import 'package:flutter_chat_demo/tools/net_service/api.dart';
import 'package:flutter_chat_demo/tools/net_service/net_provider.dart';
import 'package:flutter_chat_demo/tools/web_socket/web_socket_prodiver.dart';
import 'package:flutter_chat_demo/user/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

/// 登陆数据管理
class LoginManager {
  static final _shared = LoginManager._();
  static const kUserInfoKey = 'LoginKey';

  /// 用户信息
  User? _user;
  User get user => _user ?? User();

  /// 是否登陆
  bool get isLogin => user.account != null && user.id != null;

  LoginManager._();

  factory LoginManager() => _shared;

  /// 初始化
  Future<void> init() async {
    // 判断是否登陆, 获取用户信息
    final prefers = GetStorage();
    final loginInfo = prefers.read(kUserInfoKey);
    if (loginInfo != null && loginInfo.isNotEmpty) {
      final info = json.decode(loginInfo) as Map<String, dynamic>;
      _user = User.fromJson(info);

      // 连接 socket
      connectSocket(user.id);
    }
  }

  // 连接 socket
  void connectSocket(int? id) => WebSocketProvider.shared.connect(id: id);

  // 断开 socket
  void disconnectSocket() => WebSocketProvider.shared.close();

  /// 登陆
  ///
  /// - account  登陆的账号
  /// - password  登陆密码
  /// - return 是否登陆成功，错误信息
  Future<(bool, String?)> login(String account, String password) async {
    final res = await NetProvider.post<Map<String, dynamic>>(
      Api.login,
      data: {'account': account, 'password': password},
    );

    if (res.status == NetStatus.success && res.content != null) {
      // 保存用户信息
      final prefers = GetStorage();
      prefers.write(kUserInfoKey, json.encode(res.content));
      _user = User.fromJson(res.content!);

      // 连接 socket
      connectSocket(user.id);

      return (true, null);
    } else {
      return (false, res.description ?? '错误');
    }
  }

  /// 退出登录
  Future<void> logout() async {
    final prefers = GetStorage();
    await prefers.write(kUserInfoKey, '');
    _user = User();

    // 断开 socket
    disconnectSocket();
  }
}
