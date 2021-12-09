import 'package:get/get.dart';
import 'package:demo7_pro/pages/webview_page/controllers/webview_controller.dart';

class WebviewBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<WebviewController>(() => WebviewController()); // 通过依赖注入实例化的控制器
  }
}