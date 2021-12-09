import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:demo7_pro/tabbar/tab_nav_get/views/tab_nav_get.dart';
import 'package:demo7_pro/tabbar/tab_nav_get/bindings/tab_nav_get_binding.dart';
import 'package:get/get.dart';
import 'package:demo7_pro/pages/webview_page/views/webview.dart'; // webview
import 'package:demo7_pro/pages/webview_page/bindings/webview_binding.dart'; // webview bindings
import 'package:demo7_pro/pages/home_page/views/home_page.dart'; // 首页
import 'package:demo7_pro/pages/home_page/bindings/home_binding.dart'; // 首页 binding
import 'package:demo7_pro/pages/my_page.dart'; // 我的
import 'package:demo7_pro/pages/search_page.dart'; // 搜索页
import 'package:demo7_pro/pages/travel_page.dart'; // 旅行页
import 'package:demo7_pro/pages/login_page/views/login_page.dart'; // 登录页
import 'package:demo7_pro/pages/login_page/bindings/login_binding.dart'; // 登录页binding
import 'package:demo7_pro/pages/speak_page.dart'; // 语音页
import 'package:demo7_pro/pages/cashier/cashier.dart'; // 收款页
import 'package:demo7_pro/pages/filter_page/filter_page.dart'; // 筛选页
import 'package:demo7_pro/pages/flutter_json_bean_factory_test/flutter_json_bean_factory.dart'; // flutter_json_bean页面
import 'package:demo7_pro/pages/html_editor_page/html_editor.dart'; // html editor页面
import 'package:demo7_pro/pages/submit_page/submit_page.dart'; // 畅捷签提交页面
import 'package:demo7_pro/pages/root/views/root_view.dart'; // 根路径页面
import 'package:demo7_pro/pages/root/bindings/root_binding.dart'; // 根路径页面binding
import 'package:demo7_pro/middleware/auth_middleware.dart'; // 认证登录中间件

class AppGET extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<AppGET> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return GetMaterialApp.router(
      defaultTransition: Transition.native,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'), // English
      ],
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: (BuildContext context, Widget child) {
        child = botToastBuilder(context, child);
        return child;
      },
      getPages: [
        GetPage(
            name: '/',
            // 实际实验反复尝试，要挂出根节点
            page: () => RootView(),
            // 根节点要指向initRoute到/tabbar
            participatesInRootNavigator: true,
            // 加入到根导航中，否则tabbar无法保持navigatItem渲染？？？我也不知道，找半天没找到文档为什么
            preventDuplicates: true,
            bindings: [
              RootBinding()
            ],
            children: [
              GetPage(
                  name: '/tabbar',
                  page: () => TabNavigatorGet(),
                  participatesInRootNavigator: false,
                  preventDuplicates: false,
                  bindings: [
                    TabbarBinding()
                  ],
                  children: [
                    GetPage(
                        name: '/home',
                        page: () => MyHomePage(),
                        bindings: [HomeBinding()]), // tabbar页面 - 首页
                    GetPage(
                        name: '/search',
                        page: () => SearchPage()), // tabbar页面 - 搜索页
                    GetPage(
                        name: '/travel',
                        page: () => TravelPage()), // tabbar页面 - 旅行页面
                    GetPage(
                      name: '/my',
                      page: () => MyPage(),
                    ), // tabbar页面 - 我的
                  ]),
              GetPage(
                  name: '/login',
                  page: () => LoginPage(),
                  bindings: [LoginBinding()]),
              // 登录页面
              GetPage(name: '/speak', page: () => SpeakPage()),
              // 语音识别页面
              GetPage(name: '/submit', page: () => SubmitPage()),
              // 提交表单页面
              GetPage(
                  name: '/webview',
                  page: () => WebView(),
                  bindings: [WebviewBinding()]),
              // webview页面
              GetPage(name: '/filter', page: () => FilterPage()),
              // 过滤器页面，含车牌键盘
              GetPage(name: '/cashier', page: () => CashierPage()),
              // 收银台页面，测试微信，支付宝支付SDK
              GetPage(name: '/htmlEdit', page: () => HtmlEditorPage()),
              // html富文本编辑器测试页面
              GetPage(
                  name: '/flutterJsonBeanFactory',
                  page: () => FlutterJsonBeanFactoryPage()),
              // flutter json bean插件调试页面
            ])
      ], // builder: (context, child) {
      //   return MyHomePage();
      // },
    );
  }
}
