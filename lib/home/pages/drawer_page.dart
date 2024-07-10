import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/common/colors.dart';
import 'package:flutter_chat_demo/common/login_manager.dart';
import 'package:flutter_chat_demo/components/cached_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 抽屉页面
class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            top: statusBarHeight + 10.h,
            bottom: 10.h,
          ),
          width: double.infinity,
          height: 150.h,
          color: AppColors.main,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CachedImageWidget(
                    width: 50.w,
                    height: 50.w,
                    radius: 50.r,
                    imageUrl: LoginManager().user.avatar ?? '',
                  ),
                  const Spacer(),
                ],
              ),
              Text(
                LoginManager().user.name ?? '无名氏',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '账号: ${LoginManager().user.account ?? '无名氏'}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: Text(
                  '我的资料',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  '设置',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
