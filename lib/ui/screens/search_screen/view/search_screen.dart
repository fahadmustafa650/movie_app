import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/controllers/movies_controller.dart';
import 'package:movie_app/ui/screens/movie_details/view/movie_details_screen.dart';
import 'package:movie_app/ui/screens/search_screen/widget/movie_grid_poster.dart';
import 'package:movie_app/ui/screens/searching_screen/view/searching_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

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
            child: FutureBuilder(
                future: moviesController.fetchAndGetAllMovies(),
                builder: (ctx, snapshot) {
                  return Obx(
                    () => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 15.0,
                      ),
                      itemCount: moviesController
                          .filterMovies(moviesController.searchText.value)
                          .length,
                      itemBuilder: (ctx, index) => MovieGridPoster(
                        movieResult: moviesController.filterMovies(
                            moviesController.searchText.value)[index],
                        onTap: () {
                          //
                          Get.to(() => MovieDetailsScreen(
                              movieResult:
                                  moviesController.moviesResultList[index]));
                        },
                      ),
                    ),
                  );
                }),
          ))
        ],
      ),
    ));
  }

  //-----------------------------------------------------------
  Padding _searchTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
      child: SizedBox(
        height: 45.0,
        child: TextFormField(
          controller: moviesController.searchController,
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
              suffixIcon: GestureDetector(
                onTap: () {
                  moviesController.searchController.clear();
                },
                child: const Icon(
                  Icons.close,
                  color: MyColors.grayColor,
                ),
              )),
        ),
      ),
    );
  }
}
