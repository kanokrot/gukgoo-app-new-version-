import 'package:flutter/material.dart';
import 'package:gukgoo/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isDarkMode = false;

  // Function to toggle between dark and light modes
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gukgoo App',
      theme: ThemeData(
        // Light theme settings
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white, // Set background to white in light mode
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,  // App bar color in light mode
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      darkTheme: ThemeData(
        // Dark theme settings
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,  // Set background to black in dark mode
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,  // App bar color in dark mode
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: LoginPage(
        onThemeChanged: _toggleTheme,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}
