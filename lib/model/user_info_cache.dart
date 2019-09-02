import 'dart:async';

import 'package:waimao/utils/sql.dart';


abstract class UserInfoInterface {
  String get username;
  String get password;
  String get site;
}

class UserInfo implements UserInfoInterface {
  String username;
  String password;
  String site;

  UserInfo({this.username, this.password, this.site});

  factory UserInfo.fromJSON(Map json){
    return UserInfo(username: json['username'],password: json['password'], site: json['site']);
  }

  Object toMap() {
    return {'username': username, 'password': password, 'site': site};
  }
}

class UserInfoControlModel {
  final String table = 'userInfo';
  Sql sql;

  UserInfoControlModel() {
    sql = Sql.setTable(table);
  }

  // 获取所有的收藏

  // 插入新的缓存
  Future insert(UserInfo userInfo) {
    var result =
        sql.insert({'username': userInfo.username, 'password': userInfo.password, 'site': userInfo.site});
    return result;
  }

  // 获取用户信息
  Future<List<UserInfo>> getAllInfo() async {
    List list = await sql.getByCondition();
    List<UserInfo> resultList = [];
    list.forEach((item){
      print(item);
      resultList.add(UserInfo.fromJSON(item));
    });
    return resultList;
  }

  // 清空表中数据
  Future deleteAll() async{
    return await sql.deleteAll();
  }
}
