import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utils/common_methods.dart';

class MovieGridPoster extends StatelessWidget {
  final MovieResult movieResult;
  final void Function()? onTap;
  const MovieGridPoster({
    super.key,
    required this.movieResult,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              style:
                  const TextStyle(fontSize: 25.0, color: MyColors.whiteColor),
            )),
      ),
    );
  }
}
