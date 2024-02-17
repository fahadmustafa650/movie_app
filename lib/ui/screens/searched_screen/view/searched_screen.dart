import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/controllers/movies_controller.dart';
import 'package:movie_app/ui/screens/movie_details/view/movie_details_screen.dart';
import 'package:movie_app/ui/screens/searched_screen/widget/movie_poster_row.dart';

class SearchedScreen extends StatelessWidget {
  SearchedScreen({
    Key? key,
  }) : super(key: key);
  final movieController = Get.put(MoviesController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: MyColors.lightGrayColor,
      body: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          //Heading Showing No of Results
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Obx(
                () => Text(
                  "${MyStrings.resFound} ${movieController.filterMovies(movieController.searchText.value).length}",
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          //Result Found Movies
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: movieController
                    .filterMovies(movieController.searchText.value)
                    .length,
                itemBuilder: (ctx, index) => MoviePosterRow(
                  movieResult: movieController
                      .filterMovies(movieController.searchText.value)[index],
                  onTap: () {
                    Get.to(() => MovieDetailsScreen(
                        movieResult: movieController.moviesResultList[index]));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
