import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:demo7_pro/utils/app.dart';
import 'package:demo7_pro/dao/search_company.dart';

class SearchCompanyController extends GetxController
    with SingleGetTickerProviderMixin {
  ScrollController nestedScrollCtrl;
  ScrollController scrollController;
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
  ].obs;
  var loading = false.obs;
  var data = <dynamic>[].obs;
  var urlData = {'pageNo': 1, 'pageSize': 10};
  var searchData = {"organizeNameLike": "", "organizeStatus": "PENDING_AUDIT"};
  var total =0 .obs;

  @override
  void onInit() {
    tabController = TabController(length: searchEnums.length, vsync: this);
    tabController.animateTo(nowStep.value);
    nestedScrollCtrl = ScrollController();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    organizeAccountNameController = TextEditingController();
    this.requestList(urlData, searchData);
    super.onInit();
  }

  @override
  void onClose() {
    nestedScrollCtrl?.dispose();
    tabController?.dispose();
    scrollController?.dispose();
    organizeAccountNameController?.dispose();
    super.onClose();
  }

  handleNameInput(String value) {
    this.organizeAccountName.value = value;
  }

  Future loadMore(){
    if(this.data.length<this.total.value){
      urlData['pageNo']+=1;
      this.requestList(urlData,searchData);

    }
  }

  // 请求获取验证码
  Future requestList(urlData, data) async {
    try {
      /// 手机号验证
      AppUtil.showLoading();
      this.loading.value = true;
      var resp = await SearchCompanyRequest.fetch(urlData, data);
      if (urlData['pageNo'] == 1) {

        this.data.value = resp['data'];
      } else {

        this.data.value = [...this.data,...resp['data']];
        print('查看赋值前${this.data}');

        print('查看赋值${this.data.length }');

      }


      this.total.value = resp['total'];

      AppUtil.showToast('请求成功');
    } catch (e) {
      AppUtil.showToast(e);
    } finally {
      this.loading.value = false;
      AppUtil.hideLoading();
    }
  }

  Future handleRefresh() async {
    urlData['pageNo'] = 1;
    urlData['pageSize'] = 10;
    await this.requestList(urlData, searchData);
    return null;
  }
}
