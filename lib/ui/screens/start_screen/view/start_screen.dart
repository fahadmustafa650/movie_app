import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/ui/screens/main_screen/view/main_screen.dart';
import 'package:movie_app/ui/screens/mqtt_connection/view/mqtt_connection_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => MainScreen());
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(MyColors.redColor),
                ),
                child: const Center(
                  child: Text(
                    "Movie App",
                    style: TextStyle(color: MyColors.whiteColor),
                  ),
                )),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const MqttScreen());
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(MyColors.lightBlueColor),
                ),
                child: const Center(
                  child: Text(
                    "Mqtt Screen",
                    style: TextStyle(color: MyColors.whiteColor),
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
