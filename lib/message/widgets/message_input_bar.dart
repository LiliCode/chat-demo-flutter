import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 输入消息的组件
class MessageInputBar extends StatelessWidget {
  final TextEditingController controller;
  final String? text;
  final VoidCallback? onTap;

  const MessageInputBar({
    super.key,
    required this.controller,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: CupertinoTextField(
                placeholder: text ?? '说点什么...',
                controller: controller,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  height: 1.2,
                ),
                placeholderStyle: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                  height: 1.2,
                ),
                // 监听回车键
                onSubmitted: (_) {
                  if (onTap != null) {
                    onTap!();
                  }
                },
              ),
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              '发送',
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}
