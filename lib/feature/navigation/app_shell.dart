import 'package:flutter/material.dart';
import 'package:zavrsni1/core/constants/app_colors.dart';
import 'package:zavrsni1/core/constants/app_strings.dart';
import '../home/home_screen.dart';
import '../menu/menu_screen.dart';
import '../assistant/assistant_screen.dart';
import '../cart/cart_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  // Dvije faze: 0 = odabir stola, 1 = glavna ljuska (menu/ai/košarica)
  bool _tableConfirmed = false;
  int? _selectedTable;
  int _shellIndex = 0; // 0 = Menu, 1 = AI Asistent

  void _setSelectedTable(int index) {
    setState(() => _selectedTable = index);
  }

  void _confirmTable() {
    setState(() {
      _tableConfirmed = true;
      _shellIndex = 0;
    });
  }

  void _backToTableSelection() {
    setState(() {
      _tableConfirmed = false;
      _selectedTable = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_tableConfirmed) {
      return Scaffold(
        appBar: AppBar(title: const Text(AppStrings.title)),
        body: MyHomePage(
          selectedTable: _selectedTable,
          onTableSelected: _setSelectedTable,
          onConfirm: _confirmTable,
        ),
      );
    }

    final shellPages = [
      const MenuScreen(),
      const AssistantScreen(),
      const CartScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Stol ${(_selectedTable ?? 0) + 1}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _backToTableSelection,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text(AppStrings.cartPage),
            ),
          ),
        ],
      ),
      body: shellPages[_shellIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _shellIndex,
        onTap: (i) => setState(() => _shellIndex = i),
        backgroundColor: AppColors.primary,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: AppStrings.menuPage,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: AppStrings.aiAssistantPage,
          ),
        ],
      ),
    );
  }
}
