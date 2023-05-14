import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/message/models/message.dart';
import 'package:flutter_chat_demo/tools/net_service/net_provider.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketProvider with WidgetsBindingObserver {
  IOWebSocketChannel? _socket;
  Stream? stream;
  bool _isConnect = false;
  bool get connectStatus => _isConnect;
  final List<void Function(dynamic)?> _dataListeners = [];
  final List<void Function()?> _doneListeners = [];
  final List<void Function(dynamic)?> _errorListeners = [];
  StreamSubscription<dynamic>? _subscription;

  static WebSocketProvider shared = WebSocketProvider._();

  WebSocketProvider._() {
    _onInit();
  }

  void _onInit() {}

  /// 添加监听器
  void addListener({
    void Function(dynamic)? onData,
    void Function()? onDone,
    void Function(dynamic)? onError,
  }) {
    if (onData != null) {
      _dataListeners.add(onData);
    }

    if (onDone != null) {
      _doneListeners.add(onDone);
    }

    if (onError != null) {
      _errorListeners.add(onError);
    }
  }

  /// 移除数据监听器
  void removeDataListener(void Function(dynamic)? onData) {
    if (_dataListeners.contains(onData)) {
      _dataListeners.remove(onData);
    }
  }

  /// 移除完成监听器
  void removeDoneListener(void Function()? onDone) {
    if (_dataListeners.contains(onDone)) {
      _dataListeners.remove(onDone);
    }
  }

  /// 移除错误监听器
  void removeErrorListener(void Function(dynamic)? onError) {
    if (_dataListeners.contains(onError)) {
      _dataListeners.remove(onError);
    }
  }

  /// 消息监听器
  void _addMessageListener() {
    _subscription = stream?.listen((data) {
      for (var e in _dataListeners) {
        e!(data);
      }
    }, onDone: () {
      for (var e in _doneListeners) {
        e!();
      }
    }, onError: (error) {
      for (var e in _errorListeners) {
        e!(error);
      }
    });
  }

  /// 连接服务器
  void connect({int? id}) {
    _socket = IOWebSocketChannel.connect(
      '${NetProvider.webSocketUrl}/ws',
      headers: {'id': id},
    );
    // 获取广播对象
    stream = _socket?.stream.asBroadcastStream();
    _isConnect = true;
    _addMessageListener();
  }

  /// 关闭连接
  void close() {
    _socket?.sink.close();
    _isConnect = false;
    _subscription?.cancel();
  }

  /// 发送消息
  ///
  /// message: 消息对象
  void sendText(Message message) =>
      _socket?.sink.add(json.encode(message.toJson()));
}
