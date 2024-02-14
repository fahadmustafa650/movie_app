import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/controllers/movies_controller.dart';
import 'package:movie_app/ui/screens/searched_screen/view/searched_screen.dart';
import 'package:movie_app/ui/screens/searching_screen/widget/searched_movie_widget.dart';

class SearchingScreen extends StatelessWidget {
  SearchingScreen({super.key});
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
      initialValue: moviesController.searchText.value,
      onChanged: (value) {
        moviesController.searchText.value = value;
      },
      decoration: InputDecoration(
          prefixIcon: GestureDetector(
            onTap: () {
              Get.to(() => SearchedScreen());
            },
            child: Icon(
              Icons.search,
              color: MyColors.grayColor,
            ),
          ),
          suffixIcon: Icon(
            Icons.close,
            color: MyColors.grayColor,
          ),
          border: InputBorder.none),
    );
  }
}
