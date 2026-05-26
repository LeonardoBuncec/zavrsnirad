import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import 'menu_data.dart';

class MenuCard extends StatelessWidget {
  final FoodItem item;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const MenuCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasQuantity = quantity > 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.menuCardRadius),
            side: hasQuantity
                ? const BorderSide(color: AppColors.primary, width: 3)
                : BorderSide.none,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.menuCardPadding),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.category,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(item.description),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('${item.price.toStringAsFixed(2)} €'),
                          const SizedBox(width: 12),
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          Text(' ${item.rating}'),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200,
                      ),
                      child: const Icon(Icons.fastfood),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onDecrease,
                          icon: const Icon(Icons.remove_circle),
                        ),
                        Text('$quantity'),
                        IconButton(
                          onPressed: onIncrease,
                          icon: const Icon(Icons.add_circle),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (hasQuantity)
          Positioned(
            top: -6,
            left: -6,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
