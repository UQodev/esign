import 'package:esign/injection.dart';
import 'package:esign/presentation/bloc/auth/authState.dart' as app_state;
import 'package:esign/presentation/bloc/auth/auth_bloc.dart';
import 'package:esign/presentation/bloc/documents.dart/document_bloc.dart';
import 'package:esign/presentation/bloc/profile/profile_bloc.dart';
import 'package:esign/presentation/layouts/baseLayout.dart';
import 'package:esign/presentation/pages/documents/document_list_page.dart';
import 'package:esign/presentation/widgets/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, app_state.AuthState>(
      builder: (context, state) {
        if (state is app_state.AuthSuccess) {
          return BlocProvider(
            create: (context) => getIt<ProfileBloc>(),
            child: BaseLayout(
              showAppBar: true,
              title: 'E-Sign',
              drawer: AppDrawer(
                userName: state.user.name,
                userEmail: state.user.email,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => getIt<DocumentBloc>(),
                              child: DocumentListPage(),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Upload Document to Sign'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        // Fallback if no user
        return const BaseLayout(
          showAppBar: true,
          title: 'E-Sign',
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
