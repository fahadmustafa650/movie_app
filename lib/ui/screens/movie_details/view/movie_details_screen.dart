import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/models/movie_model.dart';

import 'package:movie_app/ui/screens/movie_details/widget/top_movie_poster.dart';
import 'package:movie_app/ui/screens/trailer_screen/view/trailer_screen.dart';
import 'package:movie_app/ui/screens/trailer_screen/view/trailer_screen.dart';
import 'package:movie_app/utils/common_methods.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieResult movieResult;
  const MovieDetailsScreen({super.key, required this.movieResult});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopMoviePoster(
              movieUrl:
                  CommonMethods.getPosterUrlByPath(movieResult.posterPath),
              onPressTicketBtn: () {},
              onPressTrailerBtn: () {
                Get.to(() => TrailerScreen(movieResult: movieResult));
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [],
            )
          ],
        ),
      ),
    ));
  }
}
