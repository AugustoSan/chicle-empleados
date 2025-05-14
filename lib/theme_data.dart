import 'package:flutter/material.dart';

final ThemeData chicleTheme = ThemeData(
  // Colores principales
  primaryColor: Colors.blue.shade600,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: Colors.blue.shade600,
    secondary: Colors.blue.shade50, // para fondos claros
    surface: Colors.white,           // contenedores blancos
    background: Colors.blue.shade50, // fondo claro de cabecera
  ),

  // Tipografía genérica
  textTheme: const TextTheme(
    headlineLarge: TextStyle( // “Chicle”
      fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF1E88E5)),
    titleLarge: TextStyle(    // “Inicio de Sesión”
      fontSize: 24, color: Color(0xFF1E88E5)),
    bodyLarge: TextStyle(     // botones, textos genéricos
      fontSize: 18, color: Colors.white),
  ),

  // AppBar transparente (si lo usas)
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue.shade50,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.blue.shade600),
    titleTextStyle: const TextStyle(
      fontSize: 24, fontWeight: FontWeight.w600, color: Colors.blue),
  ),

  // Inputs blancos con bordes redondeados
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blue.shade600),
    ),
    hintStyle: TextStyle(color: Colors.blue.shade600),
  ),

  // Botones elevados con esquinas redondeadas
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue.shade600,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      minimumSize: const Size(double.infinity, 52),
    ),
  ),

  // Barra inferior de navegación
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue.shade600,
    unselectedItemColor: Colors.blue.shade200,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),

  // Para que al aparecer teclado reorganice el diseño
  useMaterial3: false,
);
