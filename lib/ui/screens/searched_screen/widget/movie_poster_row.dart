import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utils/common_methods.dart';

class MoviePosterRow extends StatelessWidget {
  final MovieResult movieResult;
  final void Function()? onTap;
  const MoviePosterRow({
    super.key,
    required this.movieResult,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Row(
            children: [
              Container(
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(CommonMethods.getPosterUrlByPath(
                          movieResult.posterPath))),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieResult.originalTitle,
                    style: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    movieResult.title,
                    style: const TextStyle(
                        color: MyColors.grayColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.more_horiz,
                size: 20.0,
                color: MyColors.grayColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
