import 'package:get/get.dart';

class MainController extends GetxController {
  final _currentIndex = 0.obs;
  //-------------------------------------------
  set currentScreenNo(int index) {
    _currentIndex.value = index;
  }

  //-------------------------------------------
  int get currentScreenNo => _currentIndex.value;
}
