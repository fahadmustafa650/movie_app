import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/ui/screens/home_screen/view/home_screen.dart';
import 'package:movie_app/ui/screens/search_screen/view/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: currentSelectedIndex,
          children: [
            HomeScreenWidget(),
            SearchScreen(),
            SearchScreen(),
            SearchScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
              color: MyColors.darkGrayColor,
              borderRadius: BorderRadius.circular(25.0)),
          child: BottomNavigationBar(
              currentIndex: currentSelectedIndex,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              showSelectedLabels: true,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: MyStrings.home),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: MyStrings.search),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: MyStrings.favrt),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: MyStrings.account)
              ],
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                currentSelectedIndex = index;
                setState(() {});
              }),
        ),
      ),
    );
  }
}
