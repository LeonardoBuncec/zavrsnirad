import 'package:flutter/material.dart';
import 'package:zavrsni1/core/constants/app_dimensions.dart';
import 'package:zavrsni1/core/constants/app_strings.dart';
import '../../widgets/table_card.dart';
import 'home_controller.dart';

class MyHomePage extends StatelessWidget {
  final int? selectedTable;
  final Function(int) onTableSelected;
  final VoidCallback onConfirm;

  const MyHomePage({
    super.key,
    required this.selectedTable,
    required this.onTableSelected,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final controller = HomeController();

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
            itemCount: controller.tables.length,
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
          padding: const EdgeInsets.all(AppDimensions.spacing),
          child: SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeight,
            child: ElevatedButton(
              onPressed: selectedTable == null ? null : onConfirm,
              child: const Text(AppStrings.confirmTable),
            ),
          ),
        ),
      ],
    );
  }
}
