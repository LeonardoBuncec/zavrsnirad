import 'package:flutter/material.dart';
import '../../core/constants/app_dimensions.dart';
import 'menu_data.dart';

class MenuCard extends StatefulWidget {
  final FoodItem item;
  const MenuCard({super.key, required this.item, int quantity = 0});

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = 0;
  }

  void _add() {
    setState(() {
      quantity++;
    });
  }

  void _remove() {
    setState(() {
      if (quantity > 0) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.menuCardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.menuCardPadding),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.item.category),
                  const SizedBox(height: 8),
                  Text(
                    widget.item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.item.description),
                  const SizedBox(height: 8),
                  Text('${widget.item.price.toStringAsFixed(2)} €'),
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
                    color: Colors.grey.shade300,
                  ),
                  child: const Icon(Icons.fastfood),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    IconButton(
                      onPressed: _remove,
                      icon: const Icon(Icons.remove_circle),
                    ),

                    Text(
                      '$quantity',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    IconButton(
                      onPressed: _add,
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
