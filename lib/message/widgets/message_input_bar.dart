import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onTap;

  const MessageInputBar({super.key, required this.controller, this.onTap});

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
              height: 50,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: CupertinoTextField(
                placeholder: '请输入消息...',
                controller: controller,
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
            child: const Text(
              '发送',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
