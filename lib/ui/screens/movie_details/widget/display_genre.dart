import 'package:flutter/widgets.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/controllers/genre_controllers.dart';
import 'package:movie_app/models/movie_model.dart';

class DisplayGenresListView extends StatelessWidget {
  const DisplayGenresListView({
    super.key,
    required this.movieResult,
    required this.genreController,
  });

  final MovieResult movieResult;
  final GenreControllers genreController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: SizedBox(
        height: 40.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movieResult.genreIds.length,
          itemBuilder: (ctx, index) {
            return Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(right: 5.0),
              decoration: BoxDecoration(
                  color: MyColors.lightBlueColor,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Center(
                  child: Text(
                genreController.allGenres
                    .firstWhere(
                        (element) => element.id == movieResult.genreIds[index])
                    .name!,
                style: const TextStyle(color: MyColors.whiteColor),
              )),
            );
          },
        ),
      ),
    );
  }
}
