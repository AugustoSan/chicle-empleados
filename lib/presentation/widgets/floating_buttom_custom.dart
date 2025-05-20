import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation.dart';

class FloatingButtomCustom extends StatelessWidget {
  const FloatingButtomCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = context.watch<ShellNavigatorController>();
    bool showFloatingButton = navigatorKey.selectedBottomMenuIndex >= 0 && navigatorKey.selectedBottomMenuIndex < menuBottomItems.length;
    return showFloatingButton ? FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.add),
    ) : const SizedBox.shrink();
  }
}