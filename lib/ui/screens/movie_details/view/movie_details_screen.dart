import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/controllers/genre_controllers.dart';
import 'package:movie_app/models/movie_model.dart';

import 'package:movie_app/ui/screens/movie_details/widget/top_movie_poster.dart';
import 'package:movie_app/ui/screens/trailer_screen/view/trailer_screen.dart';
import 'package:movie_app/ui/screens/trailer_screen/view/trailer_screen.dart';
import 'package:movie_app/utils/common_methods.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieResult movieResult;
  MovieDetailsScreen({super.key, required this.movieResult});
  final genreController = Get.put(GenreControllers());
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: MyColors.blackColor,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    );
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopMoviePoster(
              movieUrl:
                  CommonMethods.getPosterUrlByPath(movieResult.posterPath),
              onPressTopBtn: () {},
              onPressBottomBtn: () {
                Get.to(() => TrailerScreen(movieResult: movieResult));
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Genres",
                style: textStyle,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SizedBox(
                height: 40.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieResult.genreIds.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                      padding: EdgeInsets.all(12.0),
                      margin: EdgeInsets.only(right: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Center(
                          child: Text(
                        genreController.allGenres
                            .firstWhere((element) =>
                                element.id == movieResult.genreIds[index])
                            .name!,
                        style: TextStyle(color: Colors.white),
                      )),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 20.0),
              child: const Text(
                MyStrings.overview,
                style: textStyle,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 8.0),
              child: Text(
                movieResult.overview,
                style:
                    const TextStyle(color: MyColors.grayColor, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
