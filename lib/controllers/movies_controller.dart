import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/models/movie_model.dart';

import '../services/apis/networking.dart';

class MoviesController extends GetxController {
  final _isMoviesLoading = false.obs;
  final searchController = TextEditingController();
  final searchText = "".obs;

  final _networking = GetIt.I<NetWorkingManager>();
  final moviesResultList = <MovieResult>[].obs;

  //---------------------------------
  bool get isFetchingMovies => _isMoviesLoading.value;

  //---------------------------------
  Future<void> fetchAndGetAllMovies() async {
    _isMoviesLoading.value = true;

    try {
      final response = await _networking.apiCall(
        methodCall: MethodCall.get,
        endpoint: '3/movie/upcoming',
      );

      if (response == null || response.statusCode == null) {
        _isMoviesLoading.value = false;
        return;
      }

      if (response.statusCode! <= 201) {
        moviesResultList.value = [];
        final extractedData = response.data;
        //Extraction All Data in a single Model
        final movieModel = MoviesModel.fromJson(extractedData);
        //Getting All movies list from a model
        moviesResultList.value = movieModel.results;
        _isMoviesLoading.value = false;
      }
    } on DioException catch (error) {
      if (kDebugMode) {
        print("fetchAndGetAllMovies:DioException:error:${error.runtimeType}");
      }
      _isMoviesLoading.value = false;
      rethrow;
    } on TimeoutException catch (_) {
      _isMoviesLoading.value = false;
      rethrow;
    } catch (error) {
      if (kDebugMode) {
        print("fetchAndGetAllMovies:catch:${error.runtimeType}");
      }
      _isMoviesLoading.value = false;
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
