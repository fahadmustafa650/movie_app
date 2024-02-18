import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/genre_model.dart';
import 'package:movie_app/services/apis/networking.dart';

class GenreControllers extends GetxController {
  final _networking = GetIt.I<NetWorkingManager>();
  final _genresList = <Genres>[].obs;

  @override
  void onInit() {
    fetchAndGetAllGenres();
    super.onInit();
  }

  //----------------------------------------------------------------------
  Future<void> fetchAndGetAllGenres() async {
    //In case Genres are already loaded no need to load again

    if (_genresList.isNotEmpty) {
      return;
    }
    try {
      final response = await _networking.apiCall(
        methodCall: MethodCall.get,
        endpoint: '3/genre/movie/list',
        queryParameters: {'language': 'en'},
      );
      if (response == null || response.statusCode == null) {
        return;
      }

      if (response.statusCode! <= 201) {
        final extractedData = response.data;
        final genre = Genre.fromJson(extractedData);
        _genresList.value = genre.genres!;
      }
    } catch (e) {
      rethrow;
    }
  }

  //----------------------------------------------------------------------
  List<Genres> get allGenres => _genresList.value;
}
