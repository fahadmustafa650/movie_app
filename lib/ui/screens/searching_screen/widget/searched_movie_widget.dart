import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utils/common_methods.dart';

class SearchedMovieWidget extends StatelessWidget {
  final MovieResult movieResult;
  final void Function()? onTap;
  const SearchedMovieWidget({
    super.key,
    required this.movieResult,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 100,
            margin: const EdgeInsets.only(left: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                    image: NetworkImage(CommonMethods.getPosterUrlByPath(
                        movieResult.posterPath)),
                    fit: BoxFit.cover)),
            // child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieResult.originalTitle,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 300,
                child: Text(
                  movieResult.overview,
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 10.0,
                      color: MyColors.grayColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
