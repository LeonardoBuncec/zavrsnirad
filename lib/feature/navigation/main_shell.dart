import 'package:flutter/material.dart';

class MainShell extends StatefulWidget {
  final VoidCallback onBackHome;

  const MainShell({super.key, required this.onBackHome});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final pages = const [
    Center(child: Text("Menu")),
    Center(child: Text("AI Assistant")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],

      floatingActionButton: FloatingActionButton(
        onPressed: widget.onBackHome,
        child: const Icon(Icons.table_bar),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "AI"),
        ],
      ),
    );
  }
}
