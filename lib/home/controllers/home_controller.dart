import 'package:flutter_chat_demo/tools/net_service/net_provider.dart';
import 'package:flutter_chat_demo/user/controllers/user_controller.dart';
import 'package:flutter_chat_demo/user/models/user_model.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_demo/tools/net_service/api.dart';

class HomeController extends GetxController {
  final List<User> list = [];
  int _pageCount = 1;

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  Future<void> refreshData() async {
    _pageCount = 1;
    return await loadData();
  }

  Future<void> loadMore() async {
    _pageCount++;
    return await loadData();
  }

  Future<void> loadData() async {
    final id = Get.find<UserController>().user.id;
    final result = await NetProvider.get<List<dynamic>>(
      Api.homeList,
      query: {'id': id ?? 0},
    );
    if (result.status == NetStatus.success && result.content != null) {
      if (_pageCount == 1) {
        list.removeWhere((element) => true);
      }
      list.addAll(result.content!.map((e) => User.fromJson(e)).toList());
      update();
    }
  }
}
