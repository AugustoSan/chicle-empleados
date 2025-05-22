import 'package:chicle_app_empleados/presentation/widgets/card_menu_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

/// Pantalla que muestra dos secciones: Bebidas y Menús.
/// Usa un BottomNavigationBar para alternar entre ellas.
class MenuItemsListLandscape extends StatelessWidget {
  MenuItemsListLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // — Menús —
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle('Menús'),
              const SizedBox(height: 8),
              Expanded(
                // para mantener scroll en caso de muchos ítems
                child: FutureBuilder<List<MenuItem>>(
                  future: context.read<MenuItemProvider>().getMenus(), 
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final items = snapshot.data!;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Container(
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
                        );
                      },
                    );
                  }
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // — Bebidas —
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle('Bebidas'),
              const SizedBox(height: 8),
              // El Expanded le da altura y el Expanded interior le da ancho
              Expanded(
                child: FutureBuilder<List<MenuItem>>(
                  future: context.read<MenuItemProvider>().getBebidas(), 
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final items = snapshot.data!;
                    return GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(4),
                        children: items.map((item) => CardMenuCustom(item: item)).toList(),
                      );
                  }
                )
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // — Alimentos —
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle('Alimentos'),
              const SizedBox(height: 8),
              Expanded(
                child: FutureBuilder<List<MenuItem>>(
                  future: context.read<MenuItemProvider>().getComida(), 
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final items = snapshot.data!;
                    return GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1,
                            // SON grids independientes, scrolling vertical propio:
                            physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(4),
                        children: items.map((item) => CardMenuCustom(item: item)).toList(),
                      );
                  }
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}

