import 'package:get/get.dart';
import 'package:demo7_pro/pages/travel_page/controllers/travel_controller.dart';

class TravelBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<TravelController>(() => TravelController()); // 通过依赖注入实例化的控制器
  }
}