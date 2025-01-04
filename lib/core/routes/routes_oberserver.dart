import 'package:flutter/material.dart';

class CustomRouteObserver extends NavigatorObserver {
  String? _currentRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _currentRoute = route.settings.name;
    print('🚀 PUSHED: ${route.settings.name ?? 'No Name'}');
    print('⬅️ FROM: ${previousRoute?.settings.name ?? 'No Name'}');
    print('📍 Current Route: $_currentRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _currentRoute = previousRoute?.settings.name;
    print('🔙 POPPED: ${route.settings.name}');
    print('➡️ TO: ${previousRoute?.settings.name}');
    print('📍 Current Route: $_currentRoute');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _currentRoute = newRoute?.settings.name;
    print('🔄️ REPLACED: ${newRoute?.settings.name}');
    print('📤 TO: ${oldRoute?.settings.name}');
    print('📍 Current Route: $_currentRoute');
  }
}
