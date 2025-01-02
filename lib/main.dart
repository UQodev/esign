import 'package:esign/core/config/supabase_config.dart';
import 'package:esign/core/routes/routes_generator.dart';
import 'package:esign/core/routes/routes_name.dart';
import 'package:esign/core/routes/routes_oberserver.dart';
import 'package:esign/injection.dart';
import 'package:esign/presentation/bloc/auth/auth_bloc.dart';
import 'package:esign/presentation/bloc/auth/authEvent.dart';
import 'package:esign/presentation/bloc/auth/authState.dart';
import 'package:esign/presentation/pages/auth/login_page.dart';
import 'package:esign/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  await Supabase.initialize(
      url: SupabaseConfig.SUPABASE_URL,
      anonKey: SupabaseConfig.SUPABASE_ANON_KEY);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(CheckAuthEvent()),
      child: MaterialApp(
        title: 'E-Sign',
        debugShowCheckedModeBanner: false,
        initialRoute: RouteName.login,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorObservers: [CustomRouteObserver()],
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return const MyHomePage();
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
