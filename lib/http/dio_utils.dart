import 'dart:developer';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../utils/toast_utils.dart';

class DioUtils {
  // static const baseUrl = "http://127.0.0.1:8888";
  // static const baseUrl = "http://192.168.1.104:8888";
  static const baseUrl = "http://192.168.1.9:8888";
  // static const baseUrl = "http://47.115.211.39:9999";
  static final options = BaseOptions(
      followRedirects: false,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      sendTimeout: 15000,
      responseType: ResponseType.json,
      baseUrl: baseUrl);
  static late Dio dio = () {
    var options = BaseOptions(
        followRedirects: false,
        connectTimeout: 15000,
        receiveTimeout: 15000,
        sendTimeout: 15000,
        responseType: ResponseType.json,
        baseUrl: baseUrl);
    final dio = Dio(options);
    return dio;
  }.call();

  static void init() {
    // var options = ;

    dio = Dio(options)
      ..interceptors.add(LogInterceptor());
    // 代理
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        return 'PROXY 10.0.0.10:8888';
      };
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };
  }

  static Future<Response> post(String url,
      {dynamic params,
      bool showLoading = false,
      int? receiveTimeout,bool showLog = true}) async {
    if (showLoading) EasyLoading.show();
    try {
      log('dio begin request=====url:$url  params:$params');
      Options? option;
      if (receiveTimeout != null) option = Options(receiveTimeout: receiveTimeout);
      Response response = await dio.post(url, data: params, options: option);
      if (showLoading) EasyLoading.dismiss();
      if(showLog) log('${DateTime.now()} Dio response for ${response.requestOptions.uri}\n data: ${response.data['d']}');
      final toast = response.data["t"];
      if (toast != null) ToastUtils.show(toast);
      return response;
    } finally {
      EasyLoading.dismiss();
    }
  }
}
