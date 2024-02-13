import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/ui/screens/home_screen/widget/movie_poster.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: ListView.builder(
          itemBuilder: (ctx, index) => const MovieTitlePoster(),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        MyString.watch,
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: MyColors.blackColor),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 20.0,
              color: MyColors.blackColor,
            ))
      ],
    );
  }
}
