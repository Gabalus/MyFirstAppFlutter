import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final Function changePage;

  const MainScreen({required this.changePage});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            child: Text("Food", style: TextStyle(fontSize: 22)),
            onPressed: () => changePage(1)));
  }
}
