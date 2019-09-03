import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:waimao/main.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class NetUtils {
  static Dio instance() {
    Map<String, dynamic> optHeader = {
      'accept-language': 'zh-cn',
      'content-type': 'application/json'
    };

    var dio = new Dio(BaseOptions(connectTimeout: 30000, headers: optHeader));
    // 增加拦截器
    dio.interceptors.add(
      InterceptorsWrapper(
        // 接口请求前数据处理
        onRequest: (options) {
          options.headers['Authorization'] = sp.get('Authorization');
          return options;
        },
        // 接口成功返回时处理
        onResponse: (Response resp) {
          var result = jsonDecode(resp.toString());
          var status = result['status'];
          var message = result['message'];
          if (status == 'error') {
            Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER);
            dio.reject(message);
          }
          return resp;
        },
        // 接口报错时处理
        onError: (DioError error) {
          print('onError');
          Fluttertoast.showToast(
              msg: '网络异常',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER);
          return error;
        },
      ),
    );
    return dio;
  }

  static Future get(String url, [Map<String, dynamic> params]) async {
    var response;
    if (params != null) {
      response = await instance().get(url, queryParameters: params);
    } else {
      response = await instance().get(url);
    }
    return response.data;
  }

  static Future post(String url, Map<String, dynamic> params) async {
    var response = await instance().post(url, data: params);
    return response.data;
  }
}
