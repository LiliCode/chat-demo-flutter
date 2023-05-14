import 'package:flutter/material.dart';

class Routes {
  static String root = '/';
  static String message = '/message';
  static String login = '/login';
  static String register = '/register';

  static final RouteObserver<PageRoute> routeObserver = RouteObserver();

  Routes._();
}
