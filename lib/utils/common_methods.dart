import 'package:movie_app/services/apis/api_constants.dart';

class CommonMethods {
  static String getPosterUrlByPath(String path) {
    return "${ApiConstants.apiposterbaseUrl}$path";
  }
}
