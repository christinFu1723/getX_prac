import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:demo7_pro/pages/webview_page/controllers/webview_controller.dart';

class WebView extends GetView<WebviewController> {
  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = controller.statusBar.value ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      body: Column(
        children: [
          FractionallySizedBox(
              widthFactor: 1,
              child: _appBar(
                  Color(int.parse('0xff$statusBarColorStr')), backButtonColor)),
          Expanded(
              child: Obx(() => WebviewScaffold(
                    url: controller.url.value,
                    withZoom: true,
                    // 允许缩放
                    withLocalStorage: true,
                    hidden: true,
                    initialChild: Container(
                      color: Colors.white,
                      child: Center(
                        child: Text('waiting...'),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }

  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      color: backgroundColor,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Get.rootDelegate.popRoute(popMode: PopMode.History);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                child: Center(
                    child: Obx(() => Text(
                        controller.title.value != null
                            ? '我是-${controller.title.value}'
                            : '未知标题',
                        style: TextStyle(color: Colors.black, fontSize: 20)))))
          ],
        ),
      ),
    );
  }
}
