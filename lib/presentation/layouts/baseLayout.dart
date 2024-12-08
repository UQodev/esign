import 'package:esign/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? floatingActionButton;
  final bool showAppBar;
  final Widget? drawer;

  const BaseLayout({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.showBackButton = false,
    this.floatingActionButton,
    this.showAppBar = true,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(title ?? ''),
              backgroundColor: AppColors.primaryLight,
              automaticallyImplyLeading: showBackButton,
              leading: drawer != null
                  ? Builder(builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    })
                  : showBackButton
                      ? const BackButton()
                      : null,
              actions: actions,
            )
          : null,
      drawer: drawer,
      body: SafeArea(
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
