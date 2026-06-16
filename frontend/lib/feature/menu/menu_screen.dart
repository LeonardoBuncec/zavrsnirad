import 'package:flutter/material.dart';
import 'menu_data.dart';
import 'menu_card.dart';

class MenuScreen extends StatefulWidget {
  final List<FoodItem> items;
  final Map<int, int> quantities;
  final Function(int) onIncrease;
  final Function(int) onDecrease;

  const MenuScreen({
    super.key,
    required this.items,
    required this.quantities,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _selectedCategory = 'Sve';

  static const List<String> _categoryOrder = [
    'Bezalkoholna pića',
    'Topli napici',
    'Alkoholna pića',
    'Predjela',
    'Juhe',
    'Salate',
    'Pizze',
    'Tjestenine',
    'Glavna jela',
    'Deserti',
  ];

  List<String> get _categories {
    final cats = widget.items.map((e) => e.category).toSet().toList();
    cats.sort((a, b) {
      final ai = _categoryOrder.indexOf(a);
      final bi = _categoryOrder.indexOf(b);
      if (ai == -1 && bi == -1) return a.compareTo(b);
      if (ai == -1) return 1;
      if (bi == -1) return -1;
      return ai.compareTo(bi);
    });
    return ['Sve', ...cats];
  }

  List<FoodItem> get _filteredItems {
    return widget.items
        .where((e) =>
            _selectedCategory == 'Sve' ||
            e.category == _selectedCategory)
        .toList();
  }

  List<dynamic> get _groupedItems {
    if (_selectedCategory != 'Sve') return _filteredItems;

    final List<dynamic> result = [];
    final cats = _categories.where((c) => c != 'Sve').toList();

    for (final cat in cats) {
      final items = widget.items.where((e) => e.category == cat).toList();
      if (items.isEmpty) continue;
      result.add(cat); // header
      result.addAll(items);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupedItems;

    return Column(
      children: [
        SizedBox(
          height: 56,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = _categories[index];
              return FilterChip(
                label: Text(cat),
                selected: _selectedCategory == cat,
                onSelected: (_) => setState(() => _selectedCategory = cat),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: grouped.length,
            itemBuilder: (context, index) {
  final item = grouped[index];
  if (item is FoodItem) {
  }
              if (item is String) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          item.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 1.2,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                );
              }

              final foodItem = item as FoodItem;
              return MenuCard(
                item: foodItem,
                quantity: widget.quantities[foodItem.id] ?? 0,
                onIncrease: () => widget.onIncrease(foodItem.id),
                onDecrease: () => widget.onDecrease(foodItem.id),
              );
            },
          ),
        ),
      ],
    );
  }
}