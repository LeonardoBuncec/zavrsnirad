import 'package:flutter/material.dart';
import 'package:zavrsni1/core/constants/app_strings.dart';

import '../home/home_screen.dart';
import '../home/home_controller.dart';
import '../menu/menu_screen.dart';
import '../assistant/assistant_screen.dart';
import '../cart/cart_screen.dart';
import '../menu/menu_data.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final HomeController controller = HomeController();

  bool _tableConfirmed = false;
  int? _selectedTable;
  int _shellIndex = 0;

  final Map<int, int> _quantities = {};

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
      _quantities.clear();
    });
  }

  void _increase(int id) {
    setState(() {
      _quantities[id] = (_quantities[id] ?? 0) + 1;
    });
  }

  void _decrease(int id) {
    setState(() {
      final current = _quantities[id] ?? 0;
      if (current > 0) _quantities[id] = current - 1;
    });
  }

  int get _totalItems => _quantities.values.fold(0, (sum, q) => sum + q);

  double get _totalPrice {
    return _quantities.entries.fold(0.0, (sum, e) {
      if (e.value <= 0) return sum;
      return sum + menuItems[e.key].price * e.value;
    });
  }

  Future<void> _confirmOrder() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Potvrdi narudžbu'),
        content: Text(
          'Naručiti $_totalItems stavki za Stol ${(_selectedTable ?? 0) + 1}?\n'
          'Ukupno: ${_totalPrice.toStringAsFixed(2)} €',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Odustani'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Naruči'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() {
        _quantities.clear();
        _shellIndex = 0;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Narudžba poslana!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_tableConfirmed) {
      return Scaffold(
        appBar: AppBar(title: const Text(AppStrings.title)),
        body: MyHomePage(
          tables: controller.tables,
          selectedTable: _selectedTable,
          onTableSelected: _setSelectedTable,
          onConfirm: _confirmTable,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${AppStrings.table} ${(_selectedTable ?? 0) + 1}'),
        leading: _shellIndex == 2
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _backToTableSelection,
              ),
        actions: [
          if (_shellIndex == 2)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() => _shellIndex = 0),
            )
          else
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => setState(() => _shellIndex = 2),
            ),
        ],
      ),
      body: IndexedStack(
        index: _shellIndex,
        children: [
          MenuScreen(
            quantities: _quantities,
            onIncrease: _increase,
            onDecrease: _decrease,
          ),
          const AssistantScreen(),
          CartScreen(
            quantities: _quantities,
            onIncrease: _increase,
            onDecrease: _decrease,
            onGoToMenu: () => setState(() => _shellIndex = 0),
          ),
        ],
      ),
      bottomNavigationBar: _shellIndex == 2
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _totalItems > 0 ? _confirmOrder : null,
                    child: Text(
                      '${AppStrings.orderNow} • ${_totalPrice.toStringAsFixed(2)} €',
                    ),
                  ),
                ),
              ),
            )
          : NavigationBar(
              selectedIndex: _shellIndex,
              onDestinationSelected: (i) => setState(() => _shellIndex = i),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.menu_book),
                  label: AppStrings.menuPage,
                ),
                NavigationDestination(
                  icon: Icon(Icons.lightbulb),
                  label: AppStrings.aiAssistantPage,
                ),
              ],
            ),
    );
  }
}
