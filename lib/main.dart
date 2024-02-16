import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/ui/screens/home_screen/view/home_screen.dart';
import 'package:movie_app/ui/screens/trailer_screen/view/trailer_screen.dart';
import 'services/apis/networking.dart';

void main() {
  _beforeAppRun();
  runApp(const MyApp());
}

//-------------------------------------------------------------------
void _beforeAppRun() {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton<NetWorkingManager>(NetWorkingManager.instance);
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
      home: HomeScreen(),
    );
  }
}
