import 'package:get/get.dart';
import 'package:demo7_pro/pages/search_company/controllers/search_company_controller.dart';

class SearchCompanyBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SearchCompanyController>(() => SearchCompanyController()); // 通过依赖注入实例化的控制器
  }
}