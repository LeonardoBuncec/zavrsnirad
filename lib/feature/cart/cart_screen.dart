import 'package:flutter/material.dart';
import '../../core/constants/app_dimensions.dart';
import '../menu/menu_data.dart';
import '../menu/menu_card.dart';

class CartScreen extends StatelessWidget {
  final Map<int, int> quantities;
  final Function(int) onIncrease;
  final Function(int) onDecrease;
  final VoidCallback onGoToMenu;

  const CartScreen({
    super.key,
    required this.quantities,
    required this.onIncrease,
    required this.onDecrease,
    required this.onGoToMenu,
  });

  @override
  Widget build(BuildContext context) {
    final items = quantities.entries.where((e) => e.value > 0).toList();

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_basket_outlined, size: 80),
            const SizedBox(height: 16),
            const Text('Košarica je prazna', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onGoToMenu,
              child: const Text('Pogledaj menu'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.cartSpacing),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final entry = items[index];
        final food = menuItems[entry.key];

        return MenuCard(
          item: food,
          quantity: entry.value,
          onIncrease: () => onIncrease(entry.key),
          onDecrease: () => onDecrease(entry.key),
        );
      },
    );
  }
}
