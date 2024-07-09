import 'package:flutter_chat_demo/tools/web_socket/web_socket_prodiver.dart';
import 'package:getx_builder_wrapper/base_controller.dart';

class MainPageController extends BaseGetxController {
  @override
  void onInit() {
    super.onInit();

    // 全局监听 socket 的错误
    WebSocketProvider.shared.addListener(onDone: _onDone, onError: _onError);
  }

  @override
  void onReady() {
    super.onReady();

    request();
  }

  @override
  Future<void> request() async {
    updateSuccess();
  }

  void _onDone() {
    print('Socket 完成');
    WebSocketProvider.shared.close();
  }

  void _onError(dynamic error) {
    print('Socket 连接错误: $error');
    WebSocketProvider.shared.close();
  }

  @override
  void onClose() {
    WebSocketProvider.shared.removeDoneListener(_onDone);
    WebSocketProvider.shared.removeErrorListener(_onError);
    super.onClose();
  }
}
