import 'package:flutter/material.dart';

class CustomRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('🚀 PUSHED: ${route.settings.name}');
    print('⬅️ FROM: ${previousRoute?.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('🔙 POPPED: ${route.settings.name}');
    print('➡️ TO: ${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print('🔄️ REPLACED: ${newRoute?.settings.name}');
    print('📤 TO: ${oldRoute?.settings.name}');
  }
}
