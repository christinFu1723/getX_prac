import 'package:flutter/material.dart';
import 'package:demo7_pro/pages/travel_page/controllers/travel_controller.dart';
import 'package:get/get.dart';
import 'package:demo7_pro/model/travel_tab_model.dart';
import 'package:demo7_pro/pages/travel_page/widgets/travel_tab_page/travel_tab_page.dart';

class TravelPage extends GetView<TravelController> {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30),
              child: Obx(() => TabBar(
                  controller: controller.tabController,
                  isScrollable: true,
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                  indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(color: Color(0xff2fcfbb), width: 3),
                      insets: EdgeInsets.only(bottom: 10)),
                  tabs: _tab(controller.tabsList))),
            ),
            Flexible(
                child: Obx(() => TabBarView(
                      controller: controller.tabController,
                      children:
                          controller.tabsList.asMap().entries.map((mapItem) {
                        return TravelTabPage(
                            travelUrl: controller.travelTabModel.value.url,
                            groupChannelCode: mapItem.value.groupChannelCode,
                            tabsIndex: mapItem.key,
                            nowSltTab: controller.nowSltTab.value);
                      }).toList(),
                    )))
          ],
        ),
        Positioned(
          child: _floatBtn(),
          bottom: 30,
          right: 30,
        )
      ],
    ));
  }

  List<Widget> _tab(list) {
    List<Widget> tabs = [];

    list.forEach((TravelTabs tab) {
      Widget item = Tab(
        text: tab.labelName,
      );
      tabs.add(item);
    });
    return tabs;
  }

  Widget _floatBtn() {
    return FloatingActionButton(
      onPressed: () {
        Get.rootDelegate.toNamed('/htmlEdit');
      },
      heroTag: 'travel_page_btn',
      child: Icon(Icons.edit),
    );
  }
}
