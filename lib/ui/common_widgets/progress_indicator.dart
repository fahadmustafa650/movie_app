import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        color: MyColors.redColor,
      ),
    );
  }
}
