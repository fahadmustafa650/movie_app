import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/strings.dart';

import '../../../../constants/colors.dart';

class TopMoviePoster extends StatelessWidget {
  final void Function()? onPressTopBtn;
  final void Function()? onPressBottomBtn;
  final String movieUrl;
  const TopMoviePoster({
    super.key,
    required this.onPressTopBtn,
    required this.onPressBottomBtn,
    required this.movieUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.6,
      decoration: BoxDecoration(
          // color: Colors.red,
          image: DecorationImage(
              image: NetworkImage(movieUrl), fit: BoxFit.cover)),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: MyColors.whiteColor,
                  ),
                ),
                const Text(
                  MyStrings.watch,
                  style: TextStyle(
                      color: MyColors.whiteColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
              width: Get.width * 0.8,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(MyColors.lightBlueColor)),
                  onPressed: onPressTopBtn,
                  child: const Text(
                    MyStrings.getTkt,
                    style: TextStyle(color: MyColors.whiteColor),
                  ))),
          SizedBox(
              width: Get.width * 0.8,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(
                                  color: MyColors.lightBlueColor))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: onPressBottomBtn,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: MyColors.whiteColor,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "Watch Trailer",
                        style: TextStyle(color: MyColors.whiteColor),
                      ),
                    ],
                  ))),
          const SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}
