import 'package:get/get.dart';
import 'package:instagram_clone_coding/src/controller/bottom_nav_controller.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
  }

}