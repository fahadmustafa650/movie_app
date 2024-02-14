import 'package:flutter/material.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          _searchTextField(),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 5.0,
                ),
                itemBuilder: (ctx, index) => Container(
                      width: 200.0,
                      height: 100.0,
                      padding: const EdgeInsets.only(bottom: 20.0, left: 15.0),
                      child: const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Superman",
                            style: TextStyle(
                                fontSize: 25.0, color: MyColors.whiteColor),
                          )),
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20.0)),
                    )),
          ))
        ],
      ),
    ));
  }

  Padding _searchTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
      child: SizedBox(
        height: 45.0,
        child: TextFormField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 5.0),
              fillColor: MyColors.grayColor.withOpacity(0.2),
              filled: true,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: MyColors.grayColor,
                  ),
                  borderRadius: BorderRadius.circular(20.0)),
              hintText: MyStrings.searchMov,
              prefixIcon: const Icon(
                Icons.search,
                color: MyColors.grayColor,
              ),
              suffixIcon: const Icon(
                Icons.close,
                color: MyColors.grayColor,
              )),
        ),
      ),
    );
  }
}
