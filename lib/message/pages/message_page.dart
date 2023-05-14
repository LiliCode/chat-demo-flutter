import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/message/controllers/message_controller.dart';
import 'package:flutter_chat_demo/message/widgets/message_input_bar.dart';
import 'package:flutter_chat_demo/message/widgets/message_widget.dart';
import 'package:get/get.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends State with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    // 监听 FlutterView 尺寸变化
    WidgetsBinding.instance.addPostFrameCallback((t) {
      final viewInsets = MediaQuery.of(context).viewInsets;
      if (viewInsets.bottom > 0) {
        // 键盘弹出，滚动到最底部
        Get.find<MessageController>().scrollToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MessageController>();
    controller.user = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.user?.name ?? 'TA'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Obx(
                      () => ListView.builder(
                        reverse: true, // 内容倒着展示
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        controller: controller.scrollController,
                        itemCount: controller.list.length,
                        itemBuilder: (context, index) => MessageWidget(
                          message: controller.list[index],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Obx(
                      () => !controller.scrollBottom.value
                          ? GestureDetector(
                              onTap: () {
                                // 滚动到最底部
                                controller.scrollToBottom();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: const Text(
                                  '您有新消息',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              left: false,
              right: false,
              top: false,
              child: MessageInputBar(
                controller: controller.textController,
                onTap: controller.send,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
