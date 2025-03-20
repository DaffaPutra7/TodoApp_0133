import 'package:flutter/material.dart';

// Digunakan untuk publik
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

// Digunakan untuk private/local
class _CounterPageState extends State<CounterPage> {
  List<String> listCounter = [];
  int _counter = 0;

  void addData() {
    setState(() {
      _counter += 1;
      listCounter.add(_counter.toString());
    });
  }

  void removeData() {
    setState(() {
      if (_counter > 0 && listCounter.isNotEmpty) {
        _counter--;
        listCounter.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Page')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 kolom dalam grid
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1, // Agar kotak berbentuk persegi
        ),
        itemCount: listCounter.length,
        itemBuilder: (context, index) {
          return CircleAvatar(
            backgroundColor: (index % 2 == 0) ? Colors.red : Colors.blue,
            child: Text(
              listCounter[index],
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: removeData,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10), // Mengganti spacing dengan SizedBox
          FloatingActionButton(
            onPressed: addData,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}