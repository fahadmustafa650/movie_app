import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/controllers/main_screen_controller.dart';
import 'package:movie_app/controllers/movies_controller.dart';
import 'package:movie_app/ui/common_widgets/error_message_widget.dart';
import 'package:movie_app/ui/common_widgets/progress_indicator.dart';
import 'package:movie_app/ui/screens/home_screen/widget/movie_poster.dart';
import 'package:movie_app/ui/screens/movie_details/view/movie_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });
  final moviesController = Get.put(MoviesController());
  final mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: FutureBuilder(
            future: moviesController.fetchAndGetAllMovies(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CenteredProgressIndicator();
              }
              if (snapshot.hasError) {
                return ErrorMsgContainer(
                  errorMsg: snapshot.error,
                );
              }
              return ListView.builder(
                itemCount: moviesController.moviesResultList.length,
                itemBuilder: (ctx, index) => MovieTitlePoster(
                  movieResult: moviesController.moviesResultList[index],
                  onTap: () {
                    Get.to(() => MovieDetailsScreen(
                        movieResult: moviesController.moviesResultList[index]));
                  },
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
            onPressed: () {
              mainController.currentScreenNo = 1;
            },
            icon: const Icon(
              Icons.search,
              size: 20.0,
              color: MyColors.blackColor,
            )),
      ],
    );
  }
}
