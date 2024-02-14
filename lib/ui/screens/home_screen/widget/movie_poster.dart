import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/assets.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/apis/api_constants.dart';

class MovieTitlePoster extends StatelessWidget {
  final MovieResult movieResult;
  const MovieTitlePoster({
    super.key,
    required this.movieResult,
  });

  @override
  Widget build(BuildContext context) {
    const margin =
        EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0, top: 20.0);
    const padding = EdgeInsets.only(bottom: 30.0);
    return Container(
      // color: Colors.amber,
      width: Get.width * 0.9,
      height: 200.0,
      child: Stack(
        children: [
          Container(
            width: Get.width * 0.9,
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: FadeInImage.assetNetwork(
              placeholder: MyAssets.posterHolder,
              fit: BoxFit.cover,
              image:
                  "${ApiConstants.apiposterbaseUrl}${movieResult.posterPath}",
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.5),
            child: Text(
              movieResult.originalTitle,
              style:
                  const TextStyle(color: MyColors.whiteColor, fontSize: 25.0),
            ),
          )
        ],
      ),
    );
    // child: Align(
    //     alignment: Alignment.bottomCenter,
    //     child: Text(
    //       movieResult.originalTitle,
    //       style: const TextStyle(color: MyColors.whiteColor, fontSize: 25.0),
    //     )),
  }
}
