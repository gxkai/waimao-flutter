import 'dart:async' show Future;
import 'dart:convert';
import 'package:waimao/api/api.dart';
import 'package:waimao/main.dart';
import 'package:waimao/model/keyword_count.dart';
import 'package:waimao/model/message.dart';
import 'package:waimao/model/visit_by_country_info.dart';
import 'package:waimao/model/visit_by_day_info.dart';
import 'package:waimao/model/visit_by_hour_info.dart';
import 'package:waimao/model/visit_by_os_info.dart';
import 'package:waimao/models/keyword.dart';
import 'package:waimao/models/dashboard.dart';

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
    sp.putString('site', userInfo.site);            // 网址
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
    return response['data'];
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

  // 关键词排名
  static Future<KeywordCount> visitByKeywordCount() async{
    var response = await NetUtils.get(Api.VisitByKeyword, {"limit": "1", "page": "1"});
    KeywordCount keywordCount = KeywordCount.fromJson(response['data']['count']);
    return keywordCount;
  }

  // 关键词排名
  static Future<Keyword> visitByKeywordData(Map<String,String> params) async{
    var response = await NetUtils.get(Api.VisitByKeyword, params);
    Keyword keyword = Keyword.fromJson(response['data']['data']);
    return keyword;
  }

  //首页
  static Future<Dashboard> dashboard() async{
    var response = await NetUtils.get(Api.Dashboard);
    Dashboard dashboard = Dashboard.fromJson(response['data']);
    return dashboard;
  }

  // 修改密码
  static Future changePassword(Map<String, String> params) async {
      var response = await NetUtils.post(Api.ChangePassword, params);
      return json.encode(response);
  }
}