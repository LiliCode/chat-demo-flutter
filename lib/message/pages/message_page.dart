import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/message/controllers/message_controller.dart';
import 'package:flutter_chat_demo/message/widgets/message_input_bar.dart';
import 'package:flutter_chat_demo/message/widgets/message_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 消息页面
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
      backgroundColor: const Color(0xFFF0F0F0),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Obx(
                    () => ListView.builder(
                      reverse: true, // 内容倒着展示
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      controller: controller.scrollController,
                      itemCount: controller.list.length,
                      itemBuilder: (context, index) => MessageWidget(
                        message: controller.list[index],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  right: 20.w,
                  child: Obx(
                    () => !controller.scrollBottom.value
                        ? GestureDetector(
                            onTap: () {
                              // 滚动到最底部
                              controller.scrollToBottom();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.r)),
                              ),
                              child: Text(
                                '您有新消息',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
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
    );
  }
}
