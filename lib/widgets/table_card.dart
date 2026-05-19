import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';

class TableCard extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  final bool isSelected;

  const TableCard({
    super.key,
    required this.index,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radius),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.selectedCard : AppColors.card,
            borderRadius: BorderRadius.circular(AppDimensions.radius),
            border: Border.all(color: AppColors.border, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.table_bar),
              const SizedBox(height: 8),
              Text('Stol ${index + 1}'),
            ],
          ),
        ),
      ),
    );
  }
}
