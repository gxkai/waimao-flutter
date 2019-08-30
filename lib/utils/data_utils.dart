import 'dart:async' show Future;

import 'package:waimao/api/api.dart';
import 'package:waimao/main.dart';

import './net_utils.dart';
import '../model/user_info.dart';

class DataUtils{
  // 登陆获取用户信息
  static Future<UserInfo> doLogin(Map<String,String> params) async{
    var response = await NetUtils.post(Api.DO_LOGIN, params);
    print(response['data']['user']);
    UserInfo userInfo = UserInfo.fromJson(response['data']['user']);
    sp.putString('Authorization', "${response['data']['token']['token_type']} ${response['data']['token']['access_token']}");
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

  // 登陆获取用户信息
  // ignore: missing_return
  static Future<UserInfo> VisitByHour(Map<String,String> params) async{
    var response = await NetUtils.get(Api.VisitByHour, params);
    print(response['data']);
  }
}