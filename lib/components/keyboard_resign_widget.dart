import 'package:flutter/material.dart';

/// 点击空白区域，键盘落下
class KeyboardResignFirstResponder extends StatelessWidget {
  final Widget child;
  final void Function()? after;

  const KeyboardResignFirstResponder({
    super.key,
    required this.child,
    this.after,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // 从 context 中获取 FocusScopeNode
        final node = FocusScope.of(context);
        if (!node.hasPrimaryFocus && node.focusedChild != null) {
          // 键盘落下
          FocusManager.instance.primaryFocus?.unfocus();
          // 回调
          after?.call();
        }
      },
      child: child,
    );
  }
}
