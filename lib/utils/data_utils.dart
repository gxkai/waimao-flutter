import 'dart:async' show Future;

import 'package:waimao/api/api.dart';
import 'package:waimao/main.dart';
import 'package:waimao/model/product.dart';
import 'package:waimao/model/visit_by_country_info.dart';
import 'package:waimao/model/visit_by_day_info.dart';
import 'package:waimao/model/visit_by_hour_info.dart';
import 'package:waimao/model/visit_by_os_info.dart';
import 'package:waimao/model/message.dart';

import './net_utils.dart';
import '../model/user_info.dart';

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

  // 访客流量
  static Future<List<VisitByHourInfo>> visitByHour(Map<String,String> params) async{
    var response = await NetUtils.get(Api.VisitByHour, params);
    List<Object> list = response['data'];
    List<VisitByHourInfo> vList = new List();
    list.forEach((f) {
      VisitByHourInfo visitByHourInfo = VisitByHourInfo.fromJson(f);
      vList.add(visitByHourInfo);
    });
    return vList;
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

  // 询盘列表
  static Future message(Map<String, int> params) async {
    var response = await NetUtils.get(Api.Message, params);
    List<Object> list = response['data']['data'];
    List<Message> vList = new List();
    list.forEach((f){
      Message messages = Message.fromJson(f);
      vList.add(messages);
    });
    return vList;
  }

  // 访客流量
  static Future<List<VisitByCountryInfo>> visitByCountry(Map<String,String> params) async{
    var response = await NetUtils.get(Api.VisitByCountry, params);
    List<Object> list = response['data'];
    List<VisitByCountryInfo> vList = new List();
    list.forEach((f) {
      VisitByCountryInfo visitByCountryInfo = VisitByCountryInfo.fromJson(f);
      vList.add(visitByCountryInfo);
    });
    return vList;
  }

  // 访客流量
  static Future<List<VisitByOsInfo>> visitByOs(Map<String,String> params) async{
    var response = await NetUtils.get(Api.VisitByOs, params);
    List<Object> list = response['data'];
    List<VisitByOsInfo> vList = new List();
    list.forEach((f) {
      VisitByOsInfo visitByOsInfo = VisitByOsInfo.fromJson(f);
      vList.add(visitByOsInfo);
    });
    return vList;
  }
}