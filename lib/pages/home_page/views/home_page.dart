import 'package:flutter/material.dart';
import 'package:demo7_pro/widgets/grid_nav.dart';
import 'package:demo7_pro/widgets/sub_nav.dart';
import 'package:demo7_pro/widgets/local_nav.dart';
import 'package:demo7_pro/widgets/sales_box.dart';
import 'package:demo7_pro/widgets/loading_container.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:demo7_pro/widgets/search_bar.dart';
import 'package:dio_log/dio_log.dart';
import 'package:get/get.dart';
import 'package:demo7_pro/pages/home_page/controllers/home_controller.dart';

class MyHomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    print('首页，查看是否不停在渲染');
    showDebugBtn(context, btnColor: Colors.blue);

    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Obx(() => LoadingContainer(
              isLoading: controller.loading.value,
              cover: true,
              child: Stack(children: [
                MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Stack(
                      children: [
                        RefreshIndicator(
                            onRefresh: controller.loadData,
                            child: NotificationListener(
                              onNotification: (scrollNotification) {
                                if (scrollNotification
                                        is ScrollUpdateNotification &&
                                    scrollNotification.depth == 0) {
                                  controller.onScroll(
                                      scrollNotification.metrics.pixels);
                                }
                                return false; // 必须为false
                              },
                              child: _listView,
                            )),
                        Positioned(
                            bottom: 10,
                            right: 5,
                            child: FloatingActionButton(
                              onPressed: () {
                                _jumpToSubmitPage();
                              },
                              child: Icon(Icons.add),
                            ))
                      ],
                    )),
                _appBar()
              ]),
            )));
  }

  Widget _appBar() {
    return Obx(() => Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0x66000000), Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                height: 80,
                decoration: BoxDecoration(
                    color: Color.fromARGB(
                        ((controller.opacity.value ?? 0) * 255).toInt(),
                        255,
                        255,
                        255)),
                child: SearchBar(
                  searchBarType: (controller.opacity.value ?? 0) > 0.2
                      ? SearchBarType.homeLight
                      : SearchBarType.home,
                  inputBoxClick: _jumpToSearch,
                  speakClick: _jumpToSpeak,
                  defaultText: controller.searchBarDefaultTitle,
                  leftButtonClick: () {},
                  autofocus: false,
                  focusNode: null,
                ),
              ),
            ),
            Container(
              height: (controller.opacity.value ?? 0) > 0.2 ? 0.5 : 0,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 0.5)
              ]),
            )
          ],
        ));
  }

  Widget get _banner {
    var _bannerList = controller.bannerList;

    return _bannerList != null && _bannerList.length >= 1
        ? Container(
            height: 360,
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return _wrapGesture(
                  context,
                  Image.network(
                    _bannerList[index].icon,
                    fit: BoxFit.cover,
                  ),
                  _bannerList[index].url,
                  _bannerList[index].title,
                );
              },
              itemCount: _bannerList != null ? _bannerList.length : 0,
              autoplay: true,
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ),
          )
        : Container();
  }

  Widget get _listView {
    return ListView(
      controller: controller.scrollController,
      physics: new AlwaysScrollableScrollPhysics(),
      children: [
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: controller.localList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: GridNav(gridNavModel: controller.gridNav.value),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SubNav(subNavList: controller.subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SalesBox(salesBox: controller.salesBox.value),
        ),
      ],
    );
  }

  _wrapGesture(BuildContext context, Widget widget, String url, String title) {
    return GestureDetector(
      onTap: () {
        Get.rootDelegate.toNamed('/webview', arguments: {
          "url": url,
          "title": title,
        });
      },
      child: widget,
    );
  }

  _jumpToSubmitPage() {
    Get.rootDelegate.toNamed('/submit');
  }

  _jumpToSearch() {
    Get.rootDelegate.toNamed("/tabbar/search?hideLeft=${false}", arguments: {
      "hint": controller.searchBarDefaultTitle,
    });
  }

  _jumpToSpeak() {
    Get.rootDelegate.toNamed('/speak');
  }
}
