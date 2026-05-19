import 'package:flutter/material.dart';
import 'package:zavrsni1/core/constants/app_colors.dart';
import 'package:zavrsni1/core/constants/app_strings.dart';

import '../home/home_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;
  int? _selectedTable;

  void _setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  void _setSelectedTable(int index) {
    setState(() {
      _selectedTable = index;
    });
  }

  void _confirmTable() {
    setState(() {
      _index = 1; // MENU tab
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      MyHomePage(
        title: AppStrings.tablePage,
        selectedTable: _selectedTable,
        onTableSelected: _setSelectedTable,
        onConfirm: _confirmTable,
      ),
      const Center(child: Text(AppStrings.menuPage)),
      const Center(child: Text(AppStrings.aiAssistantPage)),
      const Center(child: Text(AppStrings.cartPage)),
    ];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: _setIndex,
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
