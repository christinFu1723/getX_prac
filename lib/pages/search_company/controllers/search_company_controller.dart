import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchCompanyController extends GetxController
    with SingleGetTickerProviderMixin {
  ScrollController nestedScrollCtrl;
  TextEditingController organizeAccountNameController;
  TabController tabController;
  var nowStep = 0.obs;
  var organizeAccountName = ''.obs;
  List<Map> searchEnums = [
    {
      'label': '待审核',
      'key': 1,
    },
    {
      'label': '通过',
      'key': 1,
    },
    {
      'label': '不通过',
      'key': 1,
    },
    {
      'label': '冻结',
      'key': 1,
    },
    {
      'label': '终止',
      'key': 1,
    },
  ] .obs;
  var loading= false .obs;
  List data=[{},{},{}] .obs;

  @override
  void onInit() {
    tabController = TabController(length: searchEnums.length, vsync: this);
    tabController.animateTo(nowStep.value);
    nestedScrollCtrl = ScrollController();
    organizeAccountNameController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    nestedScrollCtrl?.dispose();
    tabController?.dispose();
    organizeAccountNameController?.dispose();
    super.onClose();
  }

  handleNameInput(String value) {
    this.organizeAccountName.value = value;
  }

  Future handleRefresh(){}
}
