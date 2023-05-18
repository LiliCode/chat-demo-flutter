import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/tools/net_service/net_provider.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class RegisterController extends GetxController {
  final accountController = TextEditingController();
  final pwdController = TextEditingController();
  final nameController = TextEditingController();
  final againPwdController = TextEditingController();
  bool _loading = false;
  bool get loading => _loading;

  void register(void Function(String?)? callback) async {
    if (accountController.text.isEmpty ||
        pwdController.text.isEmpty ||
        againPwdController.text.isEmpty ||
        nameController.text.isEmpty) {
      showToast('请输入完整的信息');
      return;
    }

    if (pwdController.text != againPwdController.text) {
      showToast('两次输入的密码不一样，请重新输入');
      return;
    }

    _loading = true;
    update();
    final res = await NetProvider.post<Map<String, dynamic>>(
      Api.register,
      data: {
        'account': accountController.text,
        'password': pwdController.text,
        'name': nameController.text
      },
    );
    _loading = false;
    update();
    if (res.status == NetStatus.success && res.content != null) {
      if (callback != null) {
        callback(null);
      }
    } else {
      if (callback != null) {
        callback(res.description ?? '错误');
      }
    }
  }
}

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
