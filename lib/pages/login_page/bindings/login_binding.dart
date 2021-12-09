import 'package:get/get.dart';
import 'package:demo7_pro/pages/login_page/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginController>(() => LoginController()); // 通过依赖注入实例化的控制器
  }
}