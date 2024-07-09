import 'package:flutter_chat_demo/tools/net_service/net_provider.dart';
import 'package:flutter_chat_demo/user/controllers/user_controller.dart';
import 'package:flutter_chat_demo/user/models/user_model.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_demo/tools/net_service/api.dart';
import 'package:getx_builder_wrapper/base_controller.dart';

/// 首页
class HomeController extends BaseListController {
  @override
  void onReady() {
    super.onReady();

    refreshData();
  }

  @override
  Future<bool> requestData(int page) async {
    final id = Get.find<UserController>().user.id;
    final result = await NetProvider.get<List<dynamic>>(
      Api.homeList,
      query: {'id': id ?? 0},
    );

    if (result.status == NetStatus.error) {
      updateError();
      return true;
    }

    if (page == 1) {
      dataSource.removeWhere((e) => true);
    }

    final list = result.content?.map((e) => User.fromJson(e)).toList() ?? [];
    dataSource.addAll(list);
    updateSuccess();

    return list.isNotEmpty;
  }
}
