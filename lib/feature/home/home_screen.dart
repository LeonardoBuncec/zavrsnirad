import 'package:flutter/material.dart';
import 'package:zavrsni1/core/constants/app_dimensions.dart';
import 'package:zavrsni1/core/constants/app_strings.dart';
import '../../widgets/table_card.dart';
import 'home_controller.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final int? selectedTable;
  final Function(int) onTableSelected;
  final VoidCallback onConfirm;

  const MyHomePage({
    super.key,
    required this.title,
    required this.selectedTable,
    required this.onTableSelected,
    required this.onConfirm,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.title)),
      body: Column(
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
                  isSelected: widget.selectedTable == index,
                  onTap: () => widget.onTableSelected(index),
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
                onPressed: widget.selectedTable == null
                    ? null
                    : widget.onConfirm,
                child: const Text(AppStrings.confirmTable),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
