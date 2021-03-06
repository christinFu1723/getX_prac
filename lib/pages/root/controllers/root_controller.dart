import 'package:get/get.dart';
import 'package:demo7_pro/utils/event_bus.dart';
import 'package:demo7_pro/eventBus/app.dart';
import 'package:demo7_pro/services/app.dart';
import 'dart:async';
import 'package:logger/logger.dart';

class RootController extends GetxController {
  /// 重新登录事件
  StreamSubscription<NeedReLoginEvent> _needLogin;

  @override
  void onInit() {
    _needLogin =
        EventBusUtil.instance.eventBus.on<NeedReLoginEvent>().listen((event) {
      needLogin();
    });
    this.init();
    super.onInit();
  }

  void init() async {
    /// 初始化应用状态
    await AppService.start();
  }

  Future<void> needLogin() async {
    await AppService.clearPrefers();
    Logger().i('检查到需要跳转登录页');

    var test =await Get.rootDelegate.canPopHistory();

    var test2 =await Get.rootDelegate.canPopPage();

    Logger().i('查看报错、?$test$test2');

    /// 转到登录页
    Get.rootDelegate.offNamed('/login');
  }
}
