import 'package:flutter/material.dart';
import '../../core/constants/app_dimensions.dart';
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

  List<String> get _categories {
    final cats = widget.items.map((e) => e.category).toSet().toList();
    return ['Sve', ...cats];
  }

  List<MapEntry<int, FoodItem>> get _filteredItems {
    return widget.items
        .asMap()
        .entries
        .where((e) =>
            _selectedCategory == 'Sve' ||
            e.value.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(AppDimensions.spacing),
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              final entry = _filteredItems[index];
              return MenuCard(
                item: entry.value,
                quantity: widget.quantities[entry.key] ?? 0,
                onIncrease: () => widget.onIncrease(entry.key),
                onDecrease: () => widget.onDecrease(entry.key),
              );
            },
          ),
        ),
      ],
    );
  }
}