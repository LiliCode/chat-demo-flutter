import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/components/cached_image.dart';
import 'package:flutter_chat_demo/user/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 聊天列表 tile
class ChatListTile extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;

  const ChatListTile({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        height: 70.h,
        child: Row(
          children: [
            CachedImageWidget(
              imageUrl: user.avatar ?? '',
              width: 50.w,
              height: 50.w,
              radius: 50.w,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    user.name ?? '无名氏',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '无消息',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
