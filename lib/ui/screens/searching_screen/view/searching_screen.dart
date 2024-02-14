import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/ui/screens/searching_screen/widget/searched_movie_widget.dart';

class SearchingScreen extends StatelessWidget {
  const SearchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: TextEditingController(),
            onChanged: (value) {},
            decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: MyColors.grayColor,
                ),
                suffixIcon: Icon(
                  Icons.close,
                  color: MyColors.grayColor,
                ),
                border: InputBorder.none),
          ),
          Expanded(child: ListView.builder(itemBuilder: (ctx, index) {
            return SearchedMovieWidget();
          }))
        ],
      ),
    ));
  }
}
