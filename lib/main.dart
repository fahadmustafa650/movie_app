import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/ui/screens/main_screen/view/main_screen.dart';
import 'package:movie_app/ui/screens/searched_screen/view/searched_screen.dart';
import 'package:movie_app/ui/screens/searching_screen/view/searching_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SearchedScreen(),
    );
  }
}
