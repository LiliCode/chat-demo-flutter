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
  }
}

class NetProvider {
  // static const host = '192.168.124.38';
  static const host = 'localhost';
  static const port = 3000;
  static const baseUrl = 'http://$host:$port';
  static const webSocketUrl = 'ws://$host:$port';

  static final _dio = Dio(
    BaseOptions(baseUrl: baseUrl),
  );

  NetProvider._();

  /// GET 请求
  ///
  /// 范型 T 表示 返回值 content 的类型
  static Future<NetResponse<T>> get<T>(String path,
      {Map<String, dynamic>? query}) async {
    final res =
        await _dio.get<Map<String, dynamic>>(path, queryParameters: query);
    if (res.data != null) {
      return NetResponse<T>.fromJson(res.data!);
    }

    return NetResponse(status: NetStatus.error, description: '没有数据');
  }

  /// POST 请求
  ///
  /// 范型 T 表示 返回值 content 的类型
  static Future<NetResponse<T>> post<T>(String path, {Object? data}) async {
    final res = await _dio.post<Map<String, dynamic>>(path, data: data);
    if (res.data != null) {
      return NetResponse<T>.fromJson(res.data!);
    }

    return NetResponse(status: NetStatus.error, description: '没有数据');
  }
}

class Api {
  static const String login = '/user/login';
  static const String register = '/user/register';
  static const String userInfo = '/user/info';
  static const String homeList = '/home/list';
}
