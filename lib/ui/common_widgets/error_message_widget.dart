import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/services/apis/dio_exceptions.dart';

class ErrorMsgContainer extends StatelessWidget {
  final dynamic errorMsg;
  const ErrorMsgContainer({
    super.key,
    required this.errorMsg,
  });

  @override
  Widget build(BuildContext context) {
    // returnErrorMsg(errorMsg);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning,
            color: MyColors.redColor,
            size: 70,
          ),
          const SizedBox(
            height: 15.0,
          ),
          Center(
            child: Text(
              returnErrorMsg(errorMsg),
              textAlign: TextAlign.center,
              style: const TextStyle(color: MyColors.redColor, fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }

  //------------------------------------------------------------
  String returnErrorMsg(dynamic error) {
    if (error.runtimeType == DioException) {
      return DioExceptions.fromDioError((error as DioException).type)
          .toString();
    } else if (error.runtimeType == TimeoutException) {
      return MyStrings.noNetMsg;
    }

    return MyStrings.someWWrong;
  }
}
