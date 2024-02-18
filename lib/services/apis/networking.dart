import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/constants/app_const.dart';
import 'package:movie_app/services/apis/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetWorkingManager {
  static final NetWorkingManager _singleton = NetWorkingManager._internal();
  static const int _maxLineWidth = 90;

  // ignore: constant_identifier_names

  BaseOptions? _options;
  Dio? _dio;

  static NetWorkingManager get instance => _singleton;

  NetWorkingManager._internal() {
    _options = BaseOptions(
      baseUrl: ApiConstants.kBaseUrl!,
      //Bug# this 15 seconds gap added to handle api response time
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );

    _dio = Dio(_options);

    _dio!.interceptors.add(
      InterceptorsWrapper(onRequest: (request, handler) async {
        String? token = ApiConstants.kToken;

        if (token == null) {
          return handler.next(request);
        } else {
          printWrapped(token);
          request.headers['Authorization'] = 'Bearer $token';
          return handler.next(request);
        }
      }, onError: (err, handler) {
        if (kDebugMode) {
          print("ErrorMsg::::${err.message}");
        }
        // throw Future.error(Exception(err.response) , );
        return handler.next(err); //
      }),
    );

    final prettyDioLogger = PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: _maxLineWidth);

    if (kDebugMode) {
      _dio!.interceptors.add(prettyDioLogger);
    }

    _dio!.interceptors.add(
      InterceptorsWrapper(onRequest: (request, handler) async {
        return handler.next(request);
      }, onError: (err, handler) {
        // throw Future.error(Exception(err.response) , );
        return handler.reject(err); //
      }),
    );
  }
  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    // ignore: avoid_print
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  Future<Response?> apiCall(
      {required MethodCall methodCall,
      required String endpoint,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body,
      Function(int, int)? downloadProgress}) async {
    switch (methodCall) {
      case MethodCall.get:
        {
          Response response = await _dio!
              .get(
                endpoint,
                queryParameters: queryParameters,
              )
              .timeout(const Duration(seconds: AppConsts.kSendTimeoutSec));

          return response;
        }

      case MethodCall.post:
        {
          Response response = await _dio!.post(
            endpoint,
            queryParameters: queryParameters,
            data: body,
            onSendProgress: (int sent, int total) {
              downloadProgress?.call(sent, total);
            },
          ).timeout(const Duration(seconds: AppConsts.kSendTimeoutSec));
          return response;
        }

      case MethodCall.patch:
        {
          // print("uploadDataToServer: apiCall: patch called");
          Response response = await _dio!
              .patch(endpoint, data: body)
              .timeout(const Duration(seconds: AppConsts.kSendTimeoutSec));

          return response;
        }

      case MethodCall.delete:
        {
          // print("uploadDataToServer: apiCall: delete called");
        }
        break;
    }
    // print("uploadDataToServer: apiCall: null return");
    return null;
  }
}

enum MethodCall { get, post, patch, delete }
