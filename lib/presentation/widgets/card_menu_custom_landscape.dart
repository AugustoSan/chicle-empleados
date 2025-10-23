import 'package:chicle_app_empleados/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/product.dart';

class CardMenuCustomLandscape extends StatelessWidget {
  final Product item;
  const CardMenuCustomLandscape({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = context.watch<ShellNavigatorController>();
    return InkWell(
      onLongPress: () => mostrarProductDialog(context, item),
      onTap: () {
        navigatorKey.navigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (ctx) => UpdateProductController(ctx.read<ProductProvider>(), item),
              child: const UpdateProductScreen()
            )
          )
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          item.name,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}