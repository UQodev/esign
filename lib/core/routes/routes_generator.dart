import 'package:esign/core/routes/routes_name.dart';
import 'package:esign/domain/entities/document.dart';
import 'package:esign/injection.dart';
import 'package:esign/presentation/bloc/profile/profile_bloc.dart';
import 'package:esign/presentation/bloc/profile/profile_event.dart';
import 'package:esign/presentation/pages/auth/login_page.dart';
import 'package:esign/presentation/pages/home_page.dart';
import 'package:esign/presentation/pages/documents/document_list_page.dart';
import 'package:esign/presentation/pages/documents/document_sign_page.dart';
import 'package:esign/presentation/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print('Generating route: ${settings.name}');

    // Handle route arguments
    final args = settings.arguments;

    switch (settings.name) {
      case RouteName.login:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteName.login),
            builder: (_) => const LoginPage());

      case RouteName.home:
        return MaterialPageRoute(builder: (_) => const MyHomePage());

      case RouteName.documents:
        return MaterialPageRoute(builder: (_) => DocumentListPage());

      case RouteName.profile:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteName.profile),
            builder: (_) => BlocProvider(
                  create: (context) => getIt<ProfileBloc>()
                    ..add(LoadProfile(userId: args as String)),
                  child: const ProfilePage(),
                ));

      case RouteName.documentSign:
        if (args is Document) {
          return MaterialPageRoute(
            builder: (_) => DocumentSignPage(document: args),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Route not found'),
        ),
      ),
    );
  }
}
