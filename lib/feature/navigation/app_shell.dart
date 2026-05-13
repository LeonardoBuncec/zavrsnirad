import 'package:flutter/material.dart';
import 'package:zavrsni1/core/constants/app_colors.dart';
import '../home/home_screen.dart';
import '../../core/constants/app_strings.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  // ignore: library_private_types_in_public_api
  static _AppShellState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppShellState>();

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  void setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  List<Widget> get pages => [
    const MyHomePage(title: "Stolovi"),
    const Center(child: Text("Menu")),
    const Center(child: Text("AI Asistent")),
    const Center(child: Text("Košarica")),
  ];

  void _onTap(int value) {
    setState(() {
      _index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.title)),

      body: pages[_index],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: _onTap,
        backgroundColor: AppColors.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.table_bar),
            label: 'Stolovi',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'AI Asistent',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Košarica',
          ),
        ],
      ),
    );
  }
}
