import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  //Variable
  int _counter = 0;
  //Method
  void _incrementCounter() {
    setState(() {
      //setstate is necessary because the value changes
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You pushed this button too many times'),
            Text(_counter.toString(), style: TextStyle(fontSize: 34)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _incrementCounter, child: Text("+")),
                ElevatedButton(onPressed: _decrementCounter, child: Text("-")),
              ],
            ),
             ElevatedButton(onPressed: _resetCounter, child: Text("Reset")),
          ],
        ),
      ),
    );
  }
}
