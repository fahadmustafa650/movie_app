import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/assets.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/apis/api_constants.dart';
import 'package:movie_app/utils/common_methods.dart';

class MovieTitlePoster extends StatelessWidget {
  final MovieResult movieResult;
  final void Function()? onTap;
  const MovieTitlePoster(
      {super.key, required this.movieResult, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const margin =
        EdgeInsets.only(bottom: 5.0, left: 20.0, right: 20.0, top: 20.0);
    // const padding = EdgeInsets.only(bottom: 30.0);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * 0.9,
        height: 200.0,
        child: Stack(
          children: [
            Container(
              width: Get.width * 0.9,
              margin: margin,
              // padding: padding,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage.assetNetwork(
                  placeholder: MyAssets.posterHolder,
                  fit: BoxFit.cover,
                  image:
                      CommonMethods.getPosterUrlByPath(movieResult.posterPath),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.5),
              child: Text(
                movieResult.originalTitle,
                style:
                    const TextStyle(color: MyColors.whiteColor, fontSize: 25.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
