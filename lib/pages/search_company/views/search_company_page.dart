import 'package:flutter/material.dart';
import 'package:demo7_pro/pages/search_company/controllers/search_company_controller.dart';
import 'package:get/get.dart';
import 'package:demo7_pro/widgets/common/input.dart' show InputForm;
import 'package:demo7_pro/config/theme.dart' show AppTheme;
import 'package:demo7_pro/widgets/loading_container.dart' show LoadingContainer;

class SearchCompanyPage extends GetView<SearchCompanyController> {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.03),
        resizeToAvoidBottomInset: false, // 解决键盘顶起页面
        body: Builder(builder: (BuildContext context) {
          return NestedScrollView(
            controller: controller.nestedScrollCtrl,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  key: Key('sliverAppTest'),
                  backgroundColor: Colors.white,
                  pinned: true,
                  stretch: false,
                  forceElevated: true,
                  toolbarHeight: 45,
                  expandedHeight: 80,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(80),
                    child: Column(
                      children: [_searchNameInput(), _tab()],
                    ),
                  ),
                ),
              ];
            },
            body: Obx(() => TabBarView(
                  controller: controller.tabController,
                  children:
                      controller.searchEnums.asMap().entries.map((mapItem) {
                    return ListViewPage(context);
                  }).toList(),
                )),
          );
        }));
  }

  Widget ListViewPage(BuildContext context) {
    return Obx(() => LoadingContainer(
          isLoading: controller.loading.value,
          cover: true,
          child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: RefreshIndicator(
                  onRefresh: controller.handleRefresh,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: NotificationListener(
                        child: Obx(() => ListView.builder(
                            controller: controller.scrollController,
                            itemCount: controller.data?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) =>
                                _child(index))),
                      )))),
        ));
  }

  Widget _child(int index) {
    var item = controller.data[index];
    return GestureDetector(
      onTap: (){
        Get.rootDelegate.toNamed('/submit?id=${item.organizeNo}&status=${item.organizeStatus}&isDetail=true');
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    borderRadius: BorderRadius.circular(5)),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.organizeName}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                              '${controller.operateStatusEnums(item.organizeStatus)}',
                              style: TextStyle(color: Colors.white)),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text('创建人：${item.platformAccountName}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                ))),
                        Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text('创建时间:${item.gmtCreate}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                )))
                      ],
                    ),
                  ))
            ]),
      ),
    );
  }

  Widget _tab() {
    return Obx(() => TabBar(
        controller: controller.tabController,
        unselectedLabelColor: AppTheme.placeholderColor,
        labelColor: AppTheme.secondColor,
        indicatorColor: AppTheme.secondColor,
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        onTap: controller.handleStatusChange,
        tabs: _tabs(controller.searchEnums)));
  }

  List<Widget> _tabs(searchEnums) {
    List<Widget> tabs = [];
    searchEnums.forEach((element) {
      tabs.add(Tab(child: Text('${element['label']}')));
    });
    return tabs;
  }

  Widget _searchNameInput() {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Row(
          children: [
            Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color.fromRGBO(0, 0, 0, 0.1)),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: _searchInput(),
                      ),
                    ))),
            Container(
              child: _searchBtn(),
              margin: EdgeInsets.only(left: 10),
            )
          ],
        ));
  }

  Widget _searchBtn() {
    return ElevatedButton(
      child: Text('搜索'),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(50, 30), padding: EdgeInsets.fromLTRB(5, 0, 5, 2)),
      onPressed: controller.handleSearchName,
    );
  }

  Widget _searchInput() {
    return InputForm(
        controller: controller.organizeAccountNameController,
        initVal: controller.organizeAccountName.value,
        validatorFn: (
          String value,
        ) {
          return '';
        },
        onChange: controller.handleNameInput,
        hintStr: '请输入管理员名称',
        textAlign: TextAlign.left,
        maxLength: 10,
        inputDecoration: InputDecoration(
          errorText: '',
          // 不显示错误提示
          errorStyle: TextStyle(color: Colors.transparent, height: 0),
          // 不显示错误提示
          counterText: "",
          // 不显示输入框最大字数统计
          border: InputBorder.none,
          isCollapsed: false,
          hintTextDirection: TextDirection.rtl,
        ));
  }
}
