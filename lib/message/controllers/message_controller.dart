import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/common/login_manager.dart';
import 'package:flutter_chat_demo/message/models/message.dart';
import 'package:flutter_chat_demo/tools/web_socket/web_socket_prodiver.dart';
import 'package:flutter_chat_demo/user/models/user_model.dart';
import 'package:get/get.dart';

/// 消息页面的控制器
class MessageController extends GetxController {
  User? user; // 当前聊天的用户(对方)
  final _list = <Message>[].obs;
  RxList<Message> get list => _list;
  RxBool scrollBottom = true.obs;

  final textController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void onReady() {
    super.onReady();

    user = Get.arguments;
  }

  @override
  void onInit() {
    super.onInit();

    // 订阅消息
    WebSocketProvider.shared.addListener(onData: _onData);

    scrollController.addListener(() {
      final t = scrollController.offset;
      const deviation = 10;
      if (t < deviation) {
        scrollBottom.value = true;
      }
    });
  }

  void _onData(dynamic data) {
    // 接收到的消息
    Map<String, dynamic> message = json.decode(data).cast<String, dynamic>();
    final msg = Message.fromJson(message).toLeftMessage();
    if (msg.from?.id == user?.id) {
      insertMessage(msg);

      final t = scrollController.offset;
      const deviation = 10;
      scrollBottom.value = t < deviation;
      if (t < deviation) {
        // 滚动到最底部
        scrollToBottom();
      }
    }
  }

  /// 插入消息
  ///
  /// msg 消息实体
  void insertMessage(Message msg) {
    if (_list.isEmpty) {
      _list.add(msg);
    } else {
      _list.insert(0, msg);
    }
  }

  void send() {
    if (textController.text.isNotEmpty) {
      // 自己的消息展示在UI上面
      final message = Message(
        to: user,
        from: LoginManager().user,
        content: MessageContent(
          msg: textController.text,
          type: MessageType.text,
        ),
      );
      // _list.add(message);
      insertMessage(message);

      // 滚动到最底部
      scrollToBottom();

      // 发送消息
      if (user != null) {
        WebSocketProvider.shared.sendText(message);
      }
    }

    textController.clear();
  }

  /// 滚动到最底部
  void scrollToBottom({int milliseconds = 100}) {
    scrollController.jumpTo(0.0);
    scrollBottom.value = true;

    // if (milliseconds <= 0) {
    //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
    //   scrollBottom.value = true;
    // } else {
    //   Future.delayed(Duration(milliseconds: milliseconds), () {
    //     scrollController.jumpTo(scrollController.position.maxScrollExtent);
    //     scrollBottom.value = true;
    //   });
    // }
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    WebSocketProvider.shared.removeDataListener(_onData);

    super.onClose();
  }
}
