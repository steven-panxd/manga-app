import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manga/pages/index/home/homeScreen.dart';
import 'package:manga/pages/index/me/meScreen.dart';
import 'package:manga/pages/index/readlist/readlistScreen.dart';
import 'package:manga/pages/index/subscription/subscriptionScreen.dart';



class IndexScreen extends StatefulWidget {
  static String routeName = '/index';

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentPageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    SubscriptionScreen(),
    ReadlistScreen(),
    MeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: this._currentPageIndex,
        children: this._pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(47, 62, 86, 1),
        selectedItemColor: Colors.white,
        selectedFontSize: ScreenUtil().setSp(12),
        unselectedFontSize: ScreenUtil().setSp(12),
        unselectedItemColor: Color.fromRGBO(100, 100, 100, 1),
        type: BottomNavigationBarType.fixed,
        currentIndex: this._currentPageIndex,
        onTap: (index) {
          setState(() {
            this._currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            title: Text('Subscription')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode),
            title: Text('ReadList')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Me')
          ),
        ]
      ),
    );
  }
}