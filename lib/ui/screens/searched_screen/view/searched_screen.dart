import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';

class SearchedScreen extends StatelessWidget {
  const SearchedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: MyColors.lightGrayColor,
      body: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Result found: 11",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (ctx, index) => Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, left: 20.0, right: 20.0),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              width: 70,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imageUrl)),
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "movie title",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " thriller",
                                  style: TextStyle(
                                      color: MyColors.grayColor,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Spacer(),
                            Icon(
                              Icons.more_horiz,
                              size: 20.0,
                              color: MyColors.grayColor,
                            )
                          ],
                        ),
                      ),
                    )),
          ),
        ],
      ),
    ));
  }
}
