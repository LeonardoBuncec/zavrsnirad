import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 10;

  void _incrementCounter() {
    setState(() {
      _counter = _counter == 0 ? 10 : _counter - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  ...List.generate(12, (index) {
                    return GestureDetector(
                      onTap: _incrementCounter,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
  color: const Color(0xFFFFF176),
  borderRadius: BorderRadius.circular(40),
  border: Border.all(
    color: const Color(0xFFFFE082),
    width: 2,
  ),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ],
),
                        child: Center(
                          child: Text(
                            'Stol ${index + 1}\n$_counter',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
                  GestureDetector(
                      onTap: _incrementCounter,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: 325,
                        height: 150,
                        decoration: BoxDecoration(
  color: const Color.fromARGB(255, 255, 236, 64),
  borderRadius: BorderRadius.circular(40),
  border: Border.all(
    color: const Color(0xFFFFE082),
    width: 2,
  ),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ],
),
                        child: Center(
                          child: Text(
                            'Potvrdi odabir stola',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}