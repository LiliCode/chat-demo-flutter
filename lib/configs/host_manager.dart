import 'package:get_storage/get_storage.dart';

/// 管理 host
class HostManager {
  static final _shared = HostManager._();
  final libHostCache = 'libHostCache';
  final _hosts = <String>[];
  List<String> get hosts => _hosts;
  String? get firstHost => hosts.isNotEmpty ? hosts.first : null;

  HostManager._() {
    _init();
  }

  factory HostManager() => _shared;

  /// 初始化配置
  void _init() {
    final storage = GetStorage();
    final data =
        storage.read<List<dynamic>>(libHostCache)?.cast<String>() ?? [];
    _hosts.addAll(data);
  }

  /// 保存 host
  Future<void> setHost(String item) async {
    _hosts.add(item);
    // 持久化
    final storage = GetStorage();
    await storage.write(libHostCache, _hosts);
  }

  /// 清除
  Future<void> clear() async {
    _hosts.clear();
    final storage = GetStorage();
    await storage.write(libHostCache, null);
  }
}
