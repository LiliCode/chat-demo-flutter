import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/message/models/message.dart';
import 'package:flutter_chat_demo/tools/icons/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 暂时消息的气泡
class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({super.key, required this.message});

  Widget _buildAvatar(String url) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          width: 40.w,
          height: 40.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 30.w,
        maxWidth: (width - 40.w - 56.w),
        minHeight: 40.h,
      ),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: MessageDiration.send == message.diration
              ? const Color.fromARGB(255, 239, 255, 222)
              : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(17.r)),
        ),
        child: Text(
          message.content?.msg ?? '',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: message.diration == MessageDiration.send
              ? [
                  Expanded(child: Container()),
                  _buildText(context),
                  SizedBox(
                    width: 6.w,
                    height: 40.h,
                    child: Stack(
                      children: [
                        Positioned(
                          left: -9.w,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: const Icon(
                            AppIcons.caretRight,
                            color: Color.fromARGB(255, 239, 255, 222),
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildAvatar(message.from?.avatar ?? '')
                ]
              : [
                  _buildAvatar(message.to?.avatar ?? ''),
                  SizedBox(
                    width: 6.w,
                    height: 40.h,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          left: -8.w,
                          top: 0,
                          bottom: 0,
                          child: const Icon(
                            AppIcons.caretLeft,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildText(context),
                  Expanded(child: Container())
                ],
        ),
        SizedBox(height: 5.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMessage(context);
  }
}
