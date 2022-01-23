import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo7_pro/dao/travel_tab_dao.dart';
import 'package:demo7_pro/model/travel_tab_model.dart';

class TravelController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController tabController;
  var tabsList = <TravelTabs>[].obs; // rx List 在渲染时直接用，不需要取value
  var travelTabModel = TravelTabModel().obs;
  var nowSltTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 0, vsync: this);

    tabController.addListener(() {
      nowSltTab.value = tabController.index;
    });

    _loadTabs();
  }

  @override
  void onReady() {
    super.onReady();

    _loadTabs();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  _loadTabs() async {
    try {
      var res = await TravelTabDao.fetch();

      TravelTabModel model = res['TravelTabModel'];

      tabController = TabController(length: model.tabs.length, vsync: this);
      travelTabModel.value = model;
      tabsList.value = model.tabs;
    } catch (e) {
      print('报错了吗：$e');
    }
  }
}
