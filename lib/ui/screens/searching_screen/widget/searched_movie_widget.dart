import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';

class SearchedMovieWidget extends StatelessWidget {
  const SearchedMovieWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 100,
            margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover)),
            // child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          SizedBox(
            width: 20.0,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Movie Title",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 300,
                child: Text(
                  "A paragraph (from παράγραφος 'to write beside') is a self-contained unit of discourse in writing dealing with a particular point or idea. Though not required by the orthographic conventions of any language with a writing system, paragraphs are a conventional means of organizing extended segments of prose. Wikipedia",
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
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
