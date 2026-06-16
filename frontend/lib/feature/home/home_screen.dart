import 'package:flutter/material.dart';
import '../../widgets/table_card.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';

class MyHomePage extends StatelessWidget {
  final List tables;
  final int? selectedTable;
  final Function(int) onTableSelected;
  final VoidCallback onConfirm;

  const MyHomePage({
    super.key,
    required this.tables,
    required this.selectedTable,
    required this.onTableSelected,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(AppDimensions.spacing),

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppDimensions.spacing,
              mainAxisSpacing: AppDimensions.spacing,
            ),

            itemCount: tables.length,

            itemBuilder: (context, index) {
              return TableCard(
                index: index,
                isSelected: selectedTable == index,
                onTap: () => onTableSelected(index),
              );
            },
          ),
        ),

        Padding(
  padding: const EdgeInsets.only(
    left: AppDimensions.spacing,
    right: AppDimensions.spacing,
    bottom: 32,
  ),
  child: SafeArea(
    child: SizedBox(
      width: AppDimensions.buttonWidth,
      height: AppDimensions.buttonHeight,
      child: ElevatedButton(
        onPressed: selectedTable == null ? null : onConfirm,
        child: const Text(AppStrings.confirmTable),
      ),
    ),
  ),
),
      ],
    );
  }
}
