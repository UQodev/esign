import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? floatingActionButton;
  final bool showAppBar;

  const BaseLayout({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.showBackButton = false,
    this.floatingActionButton,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(title ?? ''),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              automaticallyImplyLeading: showBackButton,
              actions: actions,
            )
          : null,
      body: SafeArea(
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
