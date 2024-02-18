import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movie_app/controllers/main_screen_controller.dart';
import 'package:movie_app/ui/screens/home_screen/view/home_screen.dart';
import 'package:movie_app/ui/screens/main_screen/widget/custom_nav_bar.dart';
import 'package:movie_app/ui/screens/search_screen/view/search_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            index: mainController.currentScreenNo,
            children: [
              HomeScreen(),
              SearchScreen(),
              Container(
                child: Center(child: Text("Favorite")),
              ),
              Container(
                child: Center(child: Text("Account")),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}
