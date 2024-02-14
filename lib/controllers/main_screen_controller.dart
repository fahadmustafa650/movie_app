import 'package:get/get.dart';

class MainController extends GetxController {
  final _currentScreenIndex = 0.obs;
  //-------------------------------------------
  set currentScreenNo(int index) {
    _currentScreenIndex.value = index;
  }

  //-------------------------------------------
  int get currentScreenNo => _currentScreenIndex.value;
}
