import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manga/db/models.dart';
import 'package:manga/widget/mangaSwiper.dart';


class BluredBackgroundWithMangaSwiper extends StatefulWidget {
  final List<MangaSwiperItemModel> data;

  BluredBackgroundWithMangaSwiper({
    Key key,
    this.data
  }) : super(key: key);

  @override
  _BluredBackgroundWithMangaSwiperState createState() => _BluredBackgroundWithMangaSwiperState();
}

class _BluredBackgroundWithMangaSwiperState extends State<BluredBackgroundWithMangaSwiper> {
  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    if (widget.data != null) {
      Widget backgroundPicture = Positioned(
        left: 0,
        right: 0,
        child: Image.network(
            widget.data[_currentIndex].image,
            fit: BoxFit.fitWidth,
            width: ScreenUtil.screenWidth,
            height: ScreenUtil().setHeight(365),
          )
      );

      Widget blur = Positioned(
        left: 0,
        right: 0,
        child: Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(365),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Color.fromRGBO(255, 255, 255, 0.5),
            ),
          ),
        )
      );

      Widget swiper = Container(
        margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight + ScreenUtil().setHeight(102)),
        child: MangaSwiper(
          data: widget.data,
          onIndexChanged: (index) {
            setState(() {
              this._currentIndex = index;
            });
          },
        )
      );

      return Container(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            backgroundPicture,
            blur,
            swiper
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}