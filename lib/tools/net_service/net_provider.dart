import 'package:dio/dio.dart';

enum NetStatus { success, error }

class NetResponse<T> {
  NetStatus? status;
  String? description;
  T? content;

  NetResponse({this.status, this.description, this.content});

  NetResponse.fromJson(Map<String, dynamic> json) {
    final st = json['status'];
    if (st == 'success') {
      status = NetStatus.success;
    } else if (st == 'error') {
      status = NetStatus.error;
    }

    description = json['description'];
    content = json['content'];
    print('请求的内容: $json');
  }
}

/// 网络请求
class NetProvider {
  static final _shared = NetProvider._();

  String _baseUrl = '';
  String _webSocketUrl = '';
  String get webSocketUrl => _webSocketUrl;

  Dio? _dio;

  NetProvider._();

  factory NetProvider() => _shared;

  void init(String host, bool enableLog) {
    _baseUrl = host;
    if (host.startsWith('https')) {
      _webSocketUrl = 'ws${host.replaceAll('https', '')}';
    } else if (host.startsWith('http')) {
      _webSocketUrl = 'ws${host.replaceAll('http', '')}';
    }

    _dio = Dio(
      BaseOptions(baseUrl: _baseUrl),
    );
  }

  /// GET 请求
  ///
  /// 范型 T 表示 返回值 content 的类型
  static Future<NetResponse<T>> get<T>(String path,
      {Map<String, dynamic>? query}) async {
    return await NetProvider().getData(path, query: query);
  }

  Future<NetResponse<T>> getData<T>(String path,
      {Map<String, dynamic>? query}) async {
    assert(_dio != null, '请调用初始化方法 `init()`');

    final res =
        await _dio!.get<Map<String, dynamic>>(path, queryParameters: query);
    if (res.data != null) {
      return NetResponse<T>.fromJson(res.data!);
    }

    return NetResponse(status: NetStatus.error, description: '没有数据');
  }

  /// POST 请求
  ///
  /// 范型 T 表示 返回值 content 的类型
  static Future<NetResponse<T>> post<T>(String path, {Object? data}) async {
    return await NetProvider().postData(path, data: data);
  }

  Future<NetResponse<T>> postData<T>(String path, {Object? data}) async {
    assert(_dio != null, '请调用初始化方法 `init()`');

    final res = await _dio!.post<Map<String, dynamic>>(path, data: data);
    if (res.data != null) {
      return NetResponse<T>.fromJson(res.data!);
    }

    return NetResponse(status: NetStatus.error, description: '没有数据');
  }
}
