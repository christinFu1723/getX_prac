import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:demo7_pro/utils/app.dart';
import 'package:demo7_pro/dao/search_company.dart';
import 'package:demo7_pro/dto/page_no_entity.dart' show PageNoEntity;
import 'package:demo7_pro/dto/search_company_entity.dart'
    show SearchCompanyEntity;
import 'package:demo7_pro/model/search_company_list_entity.dart'
    show SearchCompanyListData;

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
      'key': 'PENDING_AUDIT',
    },
    {
      'label': '通过',
      'key': 'NORMAL',
    },
    {
      'label': '不通过',
      'key': 'REJECTED',
    },
    {
      'label': '冻结',
      'key': 'FROZEN',
    },
    {
      'label': '终止',
      'key': 'TERMINATION',
    },
  ].obs;
  var loading = false.obs;
  var data = <SearchCompanyListData>[].obs;
  var urlData = PageNoEntity();
  var searchData = SearchCompanyEntity();
  var total = 0.obs;

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
    urlData.pageNo=1;
    urlData.pageSize=10;
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

  // 匹配枚举
  operateStatusEnums(String keyVal){
    for(var item in searchEnums){
      if(item['key'] == keyVal){
        return item['label'];
      }
    }
    return '';
  }

  // 状态栏change
  handleStatusChange(index){
    searchData.organizeStatus = searchEnums[index]['key'];
    this.handleRefresh();
  }

  // 处理输入框input
  handleNameInput(String value) {
    this.organizeAccountName.value = value;

  }

  // 搜索按钮点击，搜索名称
  handleSearchName(){
    searchData.organizeNameLike = this.organizeAccountName.value;
    this.handleRefresh();
  }

  // 分页加载更多
  Future loadMore() {
    if (this.data.length < this.total.value) {
      urlData.pageNo += 1;
      this.requestList(urlData, searchData);
    }
  }

  // 分页请求
  Future requestList(urlData, data) async {
    try {
      /// 手机号验证
      AppUtil.showLoading();
      this.loading.value = true;
      var resp = await SearchCompanyRequest.fetch(urlData, data);
      if (urlData.pageNo == 1) {
        this.data.value = resp.data;
      } else {
        this.data.value = [...this.data, ...resp.data];
        print(this.data.toJson());


      }

      this.total.value = resp.total;

      AppUtil.showToast('请求成功');
    } catch (e) {
      AppUtil.showToast(e);
    } finally {
      this.loading.value = false;
      AppUtil.hideLoading();
    }
  }

  // 分页下拉刷新
  Future handleRefresh() async {
    urlData.pageNo = 1;
    urlData.pageSize = 10;
    await this.requestList(urlData, searchData);
    return null;
  }
}
