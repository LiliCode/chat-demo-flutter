import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/posts/controllers/post_list_controller.dart';
import 'package:flutter_chat_demo/posts/widgets/post_widget.dart';
import 'package:get/get.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('帖子'),
      ),
      body: Container(
        color: Colors.white,
        child: GetBuilder<PostListController>(
          builder: (controller) => controller.list.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.list.length,
                  itemBuilder: ((context, index) {
                    return PostWidget(controller.list[index]);
                  }),
                )
              : const Center(
                  child: Text('点击右下方加号添加示例帖子'),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<PostListController>().add();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
