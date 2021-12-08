import 'package:get/get.dart';
import 'package:demo7_pro/pages/home_page/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(() => HomeController()); // 通过依赖注入实例化的控制器
  }
}