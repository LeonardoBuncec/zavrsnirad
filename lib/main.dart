import 'package:flutter/material.dart';
import 'package:zavrsni1/feature/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
  useMaterial3: true,

  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFD54F),
    brightness: Brightness.light,
  ),

  scaffoldBackgroundColor: const Color(0xFFFFF8E1),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFF176),
    foregroundColor: Colors.black,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFF212121),
    ),
  ),
),
      home: const MyHomePage(title: 'Virtual waiter'),
    );
  }
}

