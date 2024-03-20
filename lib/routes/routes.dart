import 'package:flutter/material.dart';

/// 路由
abstract class Routes {
  static String root = '/';
  static String message = '/message';
  static String login = '/login';
  static String register = '/register';
  static String hostList = '/host/list';

  static final RouteObserver<PageRoute> routeObserver = RouteObserver();
}
