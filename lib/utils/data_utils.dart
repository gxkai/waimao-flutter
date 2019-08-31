import 'dart:async' show Future;

import 'package:waimao/api/api.dart';
import 'package:waimao/main.dart';
import 'package:waimao/model/visit_by_day_info.dart';

import './net_utils.dart';
import '../model/user_info.dart';
import '../model/product.dart';

class DataUtils{
  // 登陆获取用户信息
  static Future<UserInfo> doLogin(Map<String,String> params) async{
    var response = await NetUtils.post(Api.DO_LOGIN, params);

    UserInfo userInfo = UserInfo.fromJson(response['data']['user']);
    sp.putString('Authorization', "${response['data']['token']['token_type']} ${response['data']['token']['access_token']}");
    sp.putString('role', userInfo.role);            // 角色
    sp.putString('username', userInfo.username);    // 用户名
    sp.putString('version', userInfo.version);      // 程序版本
    return userInfo;
  }

  // 验证登陆

  static Future<bool> checkLogin() async{
    var response = await NetUtils.get(Api.CHECK_LOGIN);
    print('验证登陆：$response');
    return response['success'];
  }

  // 退出登陆
    static Future<bool> logout() async{
    var response = await NetUtils.get(Api.LOGOUT);
    print('退出登陆 $response');
    return response['success'];
  }

  // 访客
  static Future visitByHour(Map<String,String> params) async{
    var response = await NetUtils.get(Api.VisitByHour, params);
    return response['data'];
  }

  // 访客流量
  static Future<List<VisitByDayInfo>> visitByDay(Map<String,String> params) async{
    var response = await NetUtils.get(Api.VisitByDay, params);
    List<Object> list = response['data'];
    List<VisitByDayInfo> vList = new List();
    list.forEach((f) {
      VisitByDayInfo visitByDayInfo = VisitByDayInfo.fromJson(f);
      vList.add(visitByDayInfo);
    });
    return vList;
  }

  // 我的产品
  static Future myProduct() async {
    var response = await NetUtils.get(Api.MyProduct);
    Product products = Product.fromJson(response['data']);
    return products;
  }
}