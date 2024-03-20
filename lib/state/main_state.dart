import 'package:flutter/material.dart';

import '../page/main_page.dart';
import '../screen/food_screen.dart';
import '../screen/main_screen.dart';

class MainState extends State<MainPage> {
  int _currentIndex = 0;
  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      MainScreen(changePage: changePage),
      FoodScreen(changePage: changePage),
    ];
  }

  void changePage(int index) {
    _currentIndex = index;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
    );
  }
}
