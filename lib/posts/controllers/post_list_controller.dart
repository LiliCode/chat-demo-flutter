import 'package:flutter_chat_demo/posts/modes/post.dart';
import 'package:get/get.dart';

class PostListController extends GetxController {
  final List<Post> _list = [];
  List<Post> get list => _list;

  void add() {
    _list.add(Post.buildTest());
    update();
  }
}
