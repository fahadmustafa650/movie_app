import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';

class MovieTitlePoster extends StatelessWidget {
  const MovieTitlePoster({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      height: 200.0,
      margin: const EdgeInsets.only(
          bottom: 10.0, left: 20.0, right: 20.0, top: 20.0),
      padding: const EdgeInsets.only(bottom: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: const Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Indiana jones and Dian of Dust",
            style: TextStyle(color: MyColors.whiteColor, fontSize: 25.0),
          )),
    );
  }
}
