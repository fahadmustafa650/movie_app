import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/controllers/movies_controller.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/apis/api_constants.dart';
import 'package:movie_app/ui/screens/searched_screen/view/searched_screen.dart';
import 'package:movie_app/ui/screens/searching_screen/view/searching_screen.dart';
import 'package:movie_app/utils/common_methods.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final moviesController = Get.put(MoviesController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          _searchTextField(),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GetX<MoviesController>(builder: (controller) {
              if (controller.isFetchingMovies) {
                return const Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 15.0,
                ),
                itemCount:
                    controller.filterMovies(controller.searchText.value).length,
                itemBuilder: (ctx, index) => MovieGridPoster(
                  movieResult: controller
                      .filterMovies(controller.searchText.value)[index],
                ),
              );
            }),
          ))
        ],
      ),
    ));
  }

  Padding _searchTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
      child: SizedBox(
        height: 45.0,
        child: TextFormField(
          onChanged: (value) {
            moviesController.searchText.value = value;
            if (value.isEmpty) {
              return;
            }

            Get.to(() => SearchingScreen());
          },
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 5.0),
              fillColor: MyColors.grayColor.withOpacity(0.2),
              filled: true,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: MyColors.grayColor,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              hintText: MyStrings.searchMov,
              prefixIcon: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                  color: MyColors.grayColor,
                ),
              ),
              suffixIcon: const Icon(
                Icons.close,
                color: MyColors.grayColor,
              )),
        ),
      ),
    );
  }
}

class MovieGridPoster extends StatelessWidget {
  final MovieResult movieResult;
  const MovieGridPoster({super.key, required this.movieResult});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 100.0,
      padding: const EdgeInsets.only(bottom: 20.0, left: 15.0),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                CommonMethods.getPosterUrlByPath(movieResult.posterPath)),
            fit: BoxFit.cover,
          ),
          // color: Colors.red,
          borderRadius: BorderRadius.circular(20.0)),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            movieResult.originalTitle,
            style: const TextStyle(fontSize: 25.0, color: MyColors.whiteColor),
          )),
    );
  }
}
