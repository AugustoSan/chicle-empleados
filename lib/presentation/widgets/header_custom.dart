import 'package:flutter/material.dart';
import 'package:chicle_app_empleados/theme_data.dart';

class HeaderCustom extends StatelessWidget {
  final String title;
  final bool onBack;
  const HeaderCustom({super.key, required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      elevation: 0,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Botón de retroceso opcional
              onBack ? IconButton(
                icon: const Icon(ChicleIcons.backPage, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ) : const SizedBox(width: 48),

              // Título centrado
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge!.color,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }
}