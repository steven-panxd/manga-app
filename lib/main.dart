import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga/pages/auth/forgetScreen.dart';
import 'package:manga/pages/auth/loginScreen.dart';
import 'package:manga/pages/auth/registerScreen.dart';
import 'package:manga/pages/index/indexScreen.dart';
import 'package:manga/pages/post/mangaDetailScreen.dart';
import 'package:manga/splashScreen.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:    Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manga',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        primaryTextTheme: TextTheme(
          display1: TextStyle(
            color: Colors.green
          )
        )
      ),
      home: SplashScreen(),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ForgetScreen.routeName: (context) => ForgetScreen(),
        IndexScreen.routeName: (context) => IndexScreen(),
        MangaDetailScreen.routeName: (context) => MangaDetailScreen()
      },
    );
  }
}
