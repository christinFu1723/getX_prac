import 'package:get/get.dart';
import 'package:demo7_pro/utils/event_bus.dart';
import 'package:demo7_pro/eventBus/app.dart';
import 'package:demo7_pro/services/app.dart';
import 'dart:async';
import 'package:logger/logger.dart';

class TabbarController extends GetxController {
  /// 重新登录事件
  StreamSubscription<NeedReLoginEvent> _needLogin;

  @override
  void onInit(){
    Logger().i('tabbar controller 检查到需要跳转登录页');
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


    /// 转到登录页
    Get.rootDelegate.offNamed('/login');
  }

}