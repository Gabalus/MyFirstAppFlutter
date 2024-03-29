import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/simple_bloc_observer.dart';

import 'page/my_home_page.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTime = TimeOfDay.now();
    final themeData = currentTime.hour >= 6 && currentTime.hour < 18
        ? ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Color(0xFFF2F2F7),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              brightness: Brightness.light,
            ),
          )
        : ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Color(0xFF000000),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              brightness: Brightness.dark,
            ),
          );
    return MaterialApp(
      theme: themeData,
      title: 'My App',
      home: const MyHomePage(),
    );
  }
}
