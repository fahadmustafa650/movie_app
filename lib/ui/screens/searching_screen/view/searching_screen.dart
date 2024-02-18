import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/controllers/movies_controller.dart';
import 'package:movie_app/ui/screens/movie_details/view/movie_details_screen.dart';
import 'package:movie_app/ui/screens/searched_screen/view/searched_screen.dart';
import 'package:movie_app/ui/screens/searching_screen/widget/searched_movie_widget.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  final moviesController = Get.put(MoviesController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          _searchField(),
          Expanded(
              child: Obx(
            () => ListView.builder(
                itemCount: moviesController
                    .filterMovies(moviesController.searchText.value)
                    .length,
                itemBuilder: (ctx, index) {
                  final filteredMoviesList = moviesController
                      .filterMovies(moviesController.searchText.value);
                  return SearchedMovieWidget(
                    movieResult: filteredMoviesList[index],
                    onTap: () {
                      Get.to(() => MovieDetailsScreen(
                          movieResult:
                              moviesController.moviesResultList[index]));
                    },
                  );
                }),
          ))
        ],
      ),
    ));
  }

  //----------------------------------------------------------------
  TextFormField _searchField() {
    return TextFormField(
      // initialValue: moviesController.searchText.value,
      controller: moviesController.searchController,
      onChanged: (value) {
        moviesController.searchText.value = value;
      },
      decoration: InputDecoration(
        prefixIcon: GestureDetector(
          onTap: () {
            if (moviesController.searchText.value.isEmpty) {
              return;
            }
            Get.to(() => SearchedScreen());
          },
          child: const Icon(
            Icons.search,
            color: MyColors.grayColor,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            moviesController.searchController.clear();
            moviesController.searchText.value = '';
            // setState(() {});
          },
          child: const Icon(
            Icons.close,
            color: MyColors.grayColor,
          ),
        ),
        border: InputBorder.none,
      ),
    );
  }
}
