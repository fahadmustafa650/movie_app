import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/controllers/genre_controllers.dart';
import 'package:movie_app/ui/screens/mqtt_connection/view/mqtt_connection_screen.dart';
import 'services/apis/networking.dart';

void main() {
  _initializationBeforeAppRun();
  runApp(const MyApp());
}

//-------------------------------------------------------------------
void _initializationBeforeAppRun() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<NetWorkingManager>(NetWorkingManager.instance);

  Get.put(GenreControllers());
}

//-------------------------------------------------------------------
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
      home: MqttScreen(),
    );
  }
}
