import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:demo7_pro/model/home_model.dart';
import 'package:demo7_pro/model/grid_nav_model.dart';
import 'package:demo7_pro/model/common_model.dart';
import 'package:demo7_pro/model/sales_box_model.dart';
import 'package:demo7_pro/dao/home_dao.dart';
import 'package:demo7_pro/services/jpush.dart' show JPushService;
import 'package:jpush_flutter/jpush_flutter.dart' show LocalNotification;

class HomeController extends GetxController {
  var appBarHideDistance = 100 ;
  var searchBarDefaultTitle = '首页(默认值)';
  var loading = true.obs;
  var model = HomeModel().obs;
  var gridNav = GridNavModel().obs; // .obs的实质是把语句转化为Rx<自定义类>
  var localList = <CommonModel>[].obs; // rx List 在渲染时直接用，不需要取value
  var subNavList = <CommonModel>[].obs;
  var bannerList = <CommonModel>[].obs;
  var salesBox = SalesBoxModel().obs;
  var scrollController = ScrollController();
  var opacity = 0.0 .obs; // top searchBar 透明度

  @override
  void onInit(){
    this.loadData();
    this.fireJpush();
    super.onInit();
  }

  @override
  void onClose(){
    scrollController.dispose();
    super.onClose();
  }


  void initScrollController(){
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {}
    });
  }


  void onScroll(val) {

    double alpha = val / appBarHideDistance;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    opacity.value=alpha;

  }

  Future loadData() async {
    // 请求后台数据渲染页面
    print('刷新');
    try {
      var _model = await HomeDao.fetch();
      model.value = _model['HomeModel'];
      gridNav.value = model.value.gridNav;
      localList.value = model.value.localNavList;
      subNavList.value = model.value.subNavList;
      salesBox.value = model.value.salesBox;
      bannerList.value = model.value.bannerList ?? [];

      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
    return null;
  }

  fireJpush(){
    // 延时1s发送极光推送
    var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch+1000);
    JPushService.sendLocal(LocalNotification(
      id: 234,
      title: '我是推送测试标题',
      buildId: 1,
      content: '看到了说明已经成功了',
      fireTime: fireDate,
      subtitle: '一个测试',
    ));
  }



}
