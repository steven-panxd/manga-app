import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manga/pages/index/indexScreen.dart';
import 'package:manga/pages/post/mangaDetailScreen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _countDown = 2;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), this._startCountDown);
  }

  void _startCountDown(Timer timer) {
    if (this._countDown > 1) {
      setState(() {
        this._countDown -= 1;
      });
    } else {
      timer.cancel();
      this._countDownFinished();
    }
  }

  void _countDownFinished() {
    Navigator.pushReplacementNamed(context, IndexScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 360, height: 640);
    return Scaffold(
      body: Container(
        child: Text("splash screen $_countDown")
      )
    );
  }
}