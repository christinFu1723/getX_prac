import 'package:flutter/material.dart';
import 'package:demo7_pro/pages/home_page.dart';
import 'package:demo7_pro/pages/my_page.dart';
import 'package:demo7_pro/pages/search_page.dart';
import 'package:demo7_pro/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(
    initialPage:3,
  );
  int _currentIndex = 3;
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [MyHomePage(), SearchPage(), TravelPage(), MyPage()],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // _controller.jumpToPage(index);
          _controller.animateToPage(index, duration: new Duration(milliseconds: 500),curve:new ElasticOutCurve(4));

          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: _activeColor,
              ),
              title: Text(
                '首页',
                style: TextStyle(
                  color: _currentIndex != 0 ? _defaultColor : _activeColor,
                ),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.search,
                color: _activeColor,
              ),
              title: Text(
                '搜索',
                style: TextStyle(
                  color: _currentIndex != 1 ? _defaultColor : _activeColor,
                ),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.camera,
                color: _activeColor,
              ),
              title: Text(
                '旅拍',
                style: TextStyle(
                  color: _currentIndex != 2 ? _defaultColor : _activeColor,
                ),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.account_circle,
                color: _activeColor,
              ),
              title: Text(
                '我的',
                style: TextStyle(
                  color: _currentIndex != 3 ? _defaultColor : _activeColor,
                ),
              ))
        ],
      ),
    );
  }
}
