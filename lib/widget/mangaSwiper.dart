// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga/db/models.dart';


class MangaSwiper extends StatefulWidget {
  final List<MangaSwiperItemModel> data;
  final ValueChanged<int> onIndexChanged;

  MangaSwiper({
    Key key,
    this.data,
    this.onIndexChanged
  }) : super(key: key);

  @override
  _MangaSwiperState createState() => _MangaSwiperState();
}

class _MangaSwiperState extends State<MangaSwiper> {
  int _currentIndex = 0;

  void _parseUrl(String url) {
    // TODO parse a function from the url
    Fluttertoast.showToast(msg: url);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.data != null) {
      Widget swiper = Container(
      height: ScreenUtil().setHeight(162),
      child: Swiper(
        onIndexChanged: (index) {
          if(widget.onIndexChanged != null) {
            widget.onIndexChanged(index);
          }
          setState(() {
            this._currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Container(
            child: Image.network(
              widget.data[index].image,
              fit: BoxFit.fill,
            )
          );
        },
        onTap: (index) {
          this._parseUrl(widget.data[index].url);
        },
        autoplay: true,
        scale: 0.5,
        viewportFraction: 0.33,
        itemCount: widget.data.length,
        ),
      );

      Widget title = Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(20), bottom: ScreenUtil().setHeight(20)),
        child: Text(
          widget.data[_currentIndex].title,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(20)
          ),
        ),
      );

      Widget pagination = MangaSwiperPagination(
        itemCount: widget.data.length, 
        currentIndex: this._currentIndex
      );

      return Container(
        child: Column(
          children: <Widget>[
            swiper,
            title,
            pagination
          ],
        )
      );
    } else {
      return Container();
    }
  }
}


class MangaSwiperPagination extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  MangaSwiperPagination({
    Key key,
    @required this.itemCount,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _swiperPaginations = List<Widget>();

    for (int i = 0; i <= itemCount - 1; i++) {
      if (i == this.currentIndex) {
        _swiperPaginations.add(
          Container(
            width: 5,
            height: 5,
            margin: EdgeInsets.only(left: 2, right: 2),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(25)
            )
          )
        );
      } else {
       _swiperPaginations.add(
          Container(
            width: 5,
            height: 5,
            margin: EdgeInsets.only(left: 2, right: 2),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.5),
              borderRadius: BorderRadius.circular(25)
            )
          )
        );
      }
    }

    return Container(
      width: ScreenUtil.screenWidth,
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _swiperPaginations,
      )
    );
  }
}