import 'package:get/get.dart';

class DrawerControllerX extends GetxController {
  var selectedRoute = ''.obs;

  void updateRoute(String route) {
    selectedRoute.value = route;
  }
}
