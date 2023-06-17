import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;
  const Counter({Key? key, 
  required this.initialValue, 
  required this.onChanged})
      : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialValue;
  }

  void increment() {
    setState(() {
      if (quantity < 9) {
        quantity += 1;
        widget.onChanged(quantity);
      }
    });
  }

  void decrement() {
    setState(() {
      if (quantity > 1) {
        quantity -= 1;
        widget.onChanged(quantity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: decrement,
          icon: const Icon(Icons.remove),
        ),
        Text('$quantity'),
        IconButton(
          onPressed: increment,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
