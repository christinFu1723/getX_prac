import 'package:get/get.dart';
import 'package:demo7_pro/tabbar/tab_nav_get/controllers/tab_controller.dart';

class TabbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabbarController>(
      () => TabbarController(),
    );
  }
}
