import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:manga/api/apiException.dart';
import 'package:manga/db/models.dart';

class ApiV1 {
  static Future<List<MangaSwiperItemModel>> getHomepageSlideData () async {
    String jsonString = await rootBundle.loadString('assets/mock/homepageSlide.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    if(jsonData['code'] != 200){
      throw ApiException(message: 'HTTP ERROR');
    }
    if(jsonData['payload'] == []) {
      return [];
    }
    List<MangaSwiperItemModel> modelList = List<MangaSwiperItemModel>();
    jsonData['payload']['slides'].forEach((item) {
      modelList.add(MangaSwiperItemModel.fromJson(item));
    });
    return modelList;
  }

  static Future<List<PostModel>> getHomepageGridViewData () async {
    String jsonString = await rootBundle.loadString('assets/mock/fourPosts.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    if(jsonData['code'] != 200){
      throw ApiException(message: 'HTTP ERROR');
    }
    if(jsonData['payload'] == []) {
      return [];
    }
    List<PostModel> modelList = List<PostModel>();
    jsonData['payload']['posts'].forEach((item) {
      modelList.add(PostModel.fromJson(item));
    });
    return modelList;
  }

  static Future<List<PostModel>> getSubscriptionData () async {
    String jsonString = await rootBundle.loadString('assets/mock/fourPosts.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    if(jsonData['code'] != 200){
      throw ApiException(message: 'HTTP ERROR');
    }
    if(jsonData['payload'] == []) {
      return [];
    }
    List<PostModel> modelList = List<PostModel>();
    jsonData['payload']['posts'].forEach((item) {
      modelList.add(PostModel.fromJson(item));
    });
    return modelList;
  }

  static Future<List<ReadlistModel>> getReadlistModelData () async {
    String jsonString = await rootBundle.loadString('assets/mock/readlist.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    if(jsonData['code'] != 200){
      throw ApiException(message: 'HTTP ERROR');
    }
    if(jsonData['payload'] == []) {
      return [];
    }
    List<ReadlistModel> modelList = List<ReadlistModel>();
    jsonData['payload']['posts'].forEach((item) {
      modelList.add(ReadlistModel.fromJson(item));
    });
    return modelList;
  }

  static Future<UserModel> getUserData () async {
    String jsonString = await rootBundle.loadString('assets/mock/user.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    if(jsonData['code'] != 200){
      throw ApiException(message: 'HTTP ERROR');
    }
    if(jsonData['payload'] == null) {
      return null;
    }
    UserModel data = UserModel.fromJson(jsonData['payload']['user']);
    return data;
  }

  static Future<PostModel> getSinglePost () async {
    String jsonString = await rootBundle.loadString('assets/mock/singlePost.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    if(jsonData['code'] != 200){
      throw ApiException(message: 'HTTP ERROR');
    }
    if(jsonData['payload'] == null) {
      return null;
    }
    PostModel data = PostModel.fromJson(jsonData['payload']['post']);
    return data;
  }
}