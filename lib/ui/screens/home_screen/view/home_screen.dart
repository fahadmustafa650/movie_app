import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/controllers/movies_controller.dart';
import 'package:movie_app/ui/screens/home_screen/widget/movie_poster.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(MoviesController());
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: GetX<MoviesController>(builder: (controller) {
          if (controller.isFetchingMovies) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: controller.moviesResultList.length,
            itemBuilder: (ctx, index) => MovieTitlePoster(
              movieResult: controller.moviesResultList[index],
            ),
          );
        }),
      ),
    );
  }

  //------------------------------------------------------
  AppBar _appBar() {
    return AppBar(
      title: const Text(
        MyStrings.watch,
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
