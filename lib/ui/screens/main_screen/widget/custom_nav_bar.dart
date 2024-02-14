import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/controllers/main_screen_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    super.key,
  });
  final mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          color: MyColors.darkGrayColor,
          borderRadius: BorderRadius.circular(25.0)),
      child: Obx(
        () => BottomNavigationBar(
            currentIndex: mainController.currentScreenNo,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            showSelectedLabels: true,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: MyStrings.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: MyStrings.search,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: MyStrings.favrt,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: MyStrings.account,
              )
            ],
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              mainController.currentScreenNo = index;
            }),
      ),
    );
  }
}
