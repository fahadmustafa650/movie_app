import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/movie_model.dart';

import '../services/apis/networking.dart';

class MoviesController extends GetxController {
  Rx<bool> _isMoviesLoading = false.obs;
  final _networking = GetIt.I<NetWorkingManager>();
  @override
  void onInit() {
    fetchAndGetAllMovies();
    super.onInit();
  }

  void fetchAndGetAllMovies() async {
    _isMoviesLoading.value = true;

    final response = await _networking.apiCall(
        methodCall: MethodCall.get,
        endpoint: 'now_playing',
        queryParameters: {
          'language': 'en-US',
          'page': 1,
        });

    final extractedData = response!.data;
    if (kDebugMode) {
      print("extractedData:${extractedData.runtimeType}");
    }
    // final decodedData = jsonDecode(extractedData);
    // MoviesModel.fromJson(decodedData);
  }
}
