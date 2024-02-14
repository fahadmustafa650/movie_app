import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/ui/screens/home_screen/view/home_screen.dart';
import 'package:movie_app/ui/screens/main_screen/view/main_screen.dart';
import 'services/apis/networking.dart';

void main() {
  GetIt.I.registerSingleton<NetWorkingManager>(NetWorkingManager.instance);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
