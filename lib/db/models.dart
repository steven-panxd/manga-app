

import 'package:flutter/material.dart';


abstract class BaseModel {
  int id;
  DateTime addTime;

  BaseModel({
    @required this.id,
    @required this.addTime
  }) : assert(id != null),
       assert(addTime != null) {
         this.addTime = DateTime.utc(this.addTime.year, this.addTime.month, this.addTime.day, this.addTime.hour, this.addTime.minute, this.addTime.second);
       }

  BaseModel.fromJson(Map<String, dynamic> data);
  // TODO Extract BaseModel class
}


class MangaSwiperItemModel extends BaseModel {
  String title;
  String image;
  String url;

  MangaSwiperItemModel({
    @required int id,
    @required DateTime addTime,
    @required this.title,
    @required this.image,
    @required this.url
  }) : assert(title != null),
       assert(image != null),
       assert(url != null),
       super(id: id,  addTime: addTime);

  MangaSwiperItemModel.fromJson(
    Map<String, dynamic> data
  ) : this(id: data['id'], 
           title: data['title'], 
           image: data['image'], 
           url: data['url'],
           addTime: DateTime.parse(data['add_time']));

}


class UserIdentityModel extends BaseModel{
  String name;

  UserIdentityModel({
    @required int id,
    @required DateTime addTime,
    @required this.name
  }) : assert(name != null),
       super(id: id, addTime: addTime);

  UserIdentityModel.fromJson(
    Map<String, dynamic> data
  ) : this(id: data['id'],
           name: data['name'],
           addTime: DateTime.parse(data['add_time']));

}


class UserModel extends BaseModel {
  String username;
  String email;
  String bio;
  String avatar;
  UserIdentityModel identity;
  int postNum;
  double coinNum;

  UserModel({
    @required int id,
    @required DateTime addTime,
    @required this.username,
    @required this.email,
    @required this.bio,
    @required this.avatar,
    @required this.identity,
    @required this.postNum,
    @required this.coinNum
  }) : assert(username != null),
       assert(email != null),
       assert(bio != null),
       assert(avatar != null),
       assert(identity != null),
       assert(postNum != null),
       assert(coinNum != null),
       super(id: id, addTime: addTime);

  UserModel.fromJson(
    Map<String, dynamic> data
  ) : this(id: data['id'],
           username: data['username'],
           email: data['email'],
           bio: data['bio'],
           avatar: data['avatar'],
           identity: UserIdentityModel.fromJson(data['identity']),
           postNum: data['post_num'],
           addTime: DateTime.parse(data['add_time']),
           coinNum: data['coin_num']);

}


class PostCategoryModel extends BaseModel{
  String name;

  PostCategoryModel({
    @required int id,
    @required DateTime addTime,
    @required this.name
  }) : assert(name != null),
       super(id: id, addTime: addTime);

  PostCategoryModel.fromJson(
    Map<String, dynamic> data
  ) : this(id: data['id'],
           name: data['name'],
           addTime: DateTime.parse(data['add_time']));

}


class ReadlistModel extends BaseModel{
  String title;
  PostCategoryModel category;
  String coverImage;
  double readProgress;

  ReadlistModel({
    @required int id,
    @required DateTime addTime,
    @required this.title,
    @required this.category,
    @required this.coverImage,
    @required this.readProgress
  }) : assert(title != null),
       assert(category != null),
       assert(coverImage != null),
       assert(readProgress != null),
       super(id: id, addTime: addTime);
      
  ReadlistModel.fromJson(
    Map<String, dynamic> data
  ) : this(id: data['id'],
           addTime: DateTime.parse(data['add_time']),
           title: data['title'],
           category: PostCategoryModel.fromJson(data['category']),
           coverImage: data['cover_image'],
           readProgress: data['read_progress']);

}


class PostModel extends BaseModel{
  UserModel uploader;
  String author;
  String title;
  PostCategoryModel category;
  String coverImage;
  bool like; // if liked
  int likeNum;
  int viewNum;
  int coinNum;
  int collectedNum;
  int commentNum;

  PostModel({
    @required int id,
    @required DateTime addTime,
    @required this.uploader,
    @required this.author,
    @required this.title,
    @required this.category,
    @required this.coverImage,
    @required this.like, // if liked
    @required this.likeNum,
    @required this.viewNum,
    @required this.coinNum,
    @required this.collectedNum,
    @required this.commentNum,
  }) : assert(uploader != null),
       assert(author != null),
       assert(title != null),
       assert(category != null),
       assert(coverImage != null),
       assert(like != null),
       assert(likeNum != null),
       assert(viewNum != null),
       assert(coinNum != null),
       assert(collectedNum != null),
       assert(commentNum != null),
       super(id: id, addTime: addTime);
      
  PostModel.fromJson(
    Map<String, dynamic> data
  ) : this(id: data['id'],
           addTime: DateTime.parse(data['add_time']),
           uploader: UserModel.fromJson(data['uploader']),
           author: data['author'],
           title: data['title'],
           category: PostCategoryModel.fromJson(data['category']),
           coverImage: data['cover_image'],
           like: data['like'],
           likeNum: data['like_num'],
           viewNum: data['view_num'],
           coinNum: data['coin_num'],
           collectedNum: data['collected_num'],
           commentNum: data['comment_num']);

}
