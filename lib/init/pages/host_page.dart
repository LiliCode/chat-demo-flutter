import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_demo/configs/host_manager.dart';
import 'package:flutter_chat_demo/routes/routes.dart';
import 'package:flutter_chat_demo/tools/net_service/net_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

/// 设置 host 的页面
class HostPage extends StatefulWidget {
  const HostPage({super.key});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  late final _hostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoTextField(
              controller: _hostController,
              placeholder: '输入IP地址或者域名',
              textAlign: TextAlign.center,
              keyboardType: TextInputType.url,
              onSubmitted: (value) {
                if (value.isEmpty) {
                  showToast('请输入内容');
                  return;
                }

                // 保存并设置
                HostManager().setHost(value);
                NetProvider().init(value, kDebugMode);
                // 推出这个页面
                Get.offAllNamed(Routes.root);
              },
            ),
            SizedBox(height: 10.h),
            Text(
              '输入的格式类似 http://192.168.1.1:3000',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.pink,
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                '确定',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
