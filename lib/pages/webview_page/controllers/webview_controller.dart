import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebviewController extends GetxController {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;
  var url = ''.obs;
  var statusBar = ''.obs;
  var title = ''.obs;
  var hideAppBar = false .obs;
  var backForbid = false.obs;
  var Catch_urls = [
    'm.ctrip.com/',
    'm.ctrip.com/html5/',
    'm.ctrip.com/html5'
  ]; // 白名单

  @override
  void onInit() {
    print('当前参数：${Get.rootDelegate.arguments()}');

    Map<String,dynamic> args = Get.rootDelegate.arguments(); // 获取路由参数

    url.value = args["url"];
    statusBar.value = args["statusBar"];
    title.value = args["title"];

    backForbid.value = args["backForbid"];

    print('当前参数：$args');
    print('当前url$url');

    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {});
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if (_isToMainPage(state.url) && !exiting) {
            if (backForbid.value) {
              // 禁止返回
              webviewReference.launch(url.value);
            } else {
              Get.rootDelegate.popRoute(popMode: PopMode.History);
              exiting = true; // 禁止重复返回
            }
          }
          break;
        default:
          break;
      }
    });
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {
      print('webview报错：$error');
    });
    super.onInit();
  }

  @override
  void onClose() {

    _onHttpError.cancel();

    _onUrlChanged.cancel();

    _onStateChanged.cancel();

    webviewReference.dispose();

    super.onClose();
  }

  bool _isToMainPage(String url) {
    bool contain = false;
    for (final val in Catch_urls) {
      if (url?.endsWith(val) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }
}
