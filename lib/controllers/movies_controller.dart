import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/models/movie_model.dart';

import '../services/apis/networking.dart';

class MoviesController extends GetxController {
  final _isMoviesLoading = false.obs;
  final _isErrorExist = false.obs;
  final searchText = "".obs;
  final _errorMsg = "".obs;
  final _networking = GetIt.I<NetWorkingManager>();
  final moviesResultList = <MovieResult>[].obs;
  //---------------------------------
  @override
  void onInit() {
    _fetchAndGetAllMovies();
    super.onInit();
  }

  //---------------------------------
  bool get isFetchingMovies => _isMoviesLoading.value;
  //---------------------------------
  bool get hasError => _isErrorExist.value;
  //---------------------------------
  Future<void> _fetchAndGetAllMovies() async {
    _isMoviesLoading.value = true;

    try {
      final response = await _networking.apiCall(
        methodCall: MethodCall.get,
        endpoint: 'now_playing',
        queryParameters: {
          'language': 'en-US',
          'page': 1,
        },
      );

      if (response == null || response.statusCode == null) {
        _isMoviesLoading.value = false;
        _errorMsg.value = MyStrings.someWWrong;
        return;
      }

      if (response.statusCode! <= 201) {
        final extractedData = response.data;
        //Extraction All Data in a single Model
        final movieModel = MoviesModel.fromJson(extractedData);
        //Getting All movies list from a model
        moviesResultList.value = movieModel.results;
        _isMoviesLoading.value = false;
      }
    } on DioException catch (error) {
      _errorMsg.value = "${error.message}";
      _isMoviesLoading.value = false;
      _isErrorExist.value = false;
      rethrow;
    } on TimeoutException catch (_) {
      _errorMsg.value = MyStrings.connTimeout;
      _isMoviesLoading.value = false;
      _isErrorExist.value = false;
      rethrow;
    } catch (error) {
      _isMoviesLoading.value = false;
      _isErrorExist.value = false;
      _errorMsg.value = MyStrings.someWWrong;
      rethrow;
    }
  }

  //---------------------------------------------------------
  List<MovieResult> filterMovies(String name) {
    if (name.isEmpty) {
      return moviesResultList;
    }

    return moviesResultList
        .where((movie) =>
            movie.originalTitle.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }
}
