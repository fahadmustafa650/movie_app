import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/strings.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioExceptionType dioError) {
    switch (dioError) {
      case DioExceptionType.cancel:
        message = MyStrings.reqApiSerCanc;
        break;
      case DioExceptionType.connectionTimeout:
        message = MyStrings.noNetMsg;
        break;
      case DioExceptionType.unknown:
        message = MyStrings.connApiServFail;
        break;
      case DioExceptionType.receiveTimeout:
        message = MyStrings.noNetMsg.tr;
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioError.hashCode, dioError);
        break;
      case DioExceptionType.sendTimeout:
        message = MyStrings.noNetMsg.tr;
        break;
      default:
        message = MyStrings.someWWrong;
        break;
    }
  }

  String message = "";

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error["message"];
      case 404:
        return error["message"];
      case 500:
        return MyStrings.intServError;
      case 401:
        return error["message"];
      default:
        return MyStrings.someWWrong;
    }
  }

  @override
  String toString() => message;
}
