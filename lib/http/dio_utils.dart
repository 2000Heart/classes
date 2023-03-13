import 'dart:developer';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../model/image_upload_result_entity.dart';
import '../utils/toast_utils.dart';

class DioUtils {

  static final baseUrl = "http://127.0.0.1:8000";
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

    // // 代理
    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   // client.findProxy = (uri) {
    //   //   return 'PROXY 10.0.0.10:8888';
    //   // };
    //   client.badCertificateCallback = (cert, host, port) {
    //     return true;
    //   };
    // };

    return dio;
  }.call();

  static void init() {
    // var options = ;

    dio = Dio(options)
      ..interceptors.add(LogInterceptor());
    // 代理
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // client.findProxy = (uri) {
      //   return 'PROXY 10.0.0.10:8888';
      // };
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };
  }

  // static Future<Response> get(
  //   String url, {
  //   dynamic params,
  //   bool isShowLoading = true,
  // }) async {
  //   if (isShowLoading) {}

  //   try {
  //     log('${DateTime.now()} Dio begin request url');
  //     log('Request data: $params');
  //     if (params != null) {
  //       params = wrapParams(params);
  //     }
  //     return await dio.get(url, queryParameters: params);
  //   } finally {
  //     // Loading.hideLoading(context);
  //   }
  // }

  static Future<Response> post(String url,
      {dynamic params,
      bool showLoading = false,
      int? receiveTimeout}) async {
    if (showLoading) {
      EasyLoading.show();
    }
    try {
      log('dio begin request=====url:$url  params:$params');
      Options? option;
      if (receiveTimeout != null) {
        option = Options(receiveTimeout: receiveTimeout);
      }
      Response response = await dio.post(url, data: params, options: option);
      if (showLoading) {
        EasyLoading.dismiss();
      }
      final toast = response.data["t"];
      if (toast != null) {
        log('${DateTime.now()} Dio response for ${response.requestOptions.uri}\n data: $toast');
        // ToastUtils.show(toast);
      }

      return response;
    } finally {
      // Loading.hideLoading(context);
    }
  }

  static Future<List<ImageUploadResultEntity>?> uploadImage(
      List<String> files, String path) async {
    EasyLoading.show();
    try {
      final filesData = [];
      for (final file in files) {
        final data = await MultipartFile.fromFile(file);
        filesData.add(data);
      }
      FormData data = FormData.fromMap({
        'path': path,
        'files': filesData,
      });
      Response result =
          await dio.post('/resource/rse-img-do/uploads', data: data);
      EasyLoading.dismiss();
      final toast = result.data['t'];
      if (toast != null) {
        ToastUtils.show(toast);
      }
      if (result.statusCode == 200 && result.data['c'] == 200) {
        List<ImageUploadResultEntity> data = result.data['d']
            .map<ImageUploadResultEntity>(
                (e) => ImageUploadResultEntity.fromJson(e))
            .toList();
        return data;
      }

      return null;
    } finally {
      // Loading.hideLoading(context);
    }
  }

  // static Map<String, dynamic> wrapParams(dynamic params) {
  //   try {
  //     String m = "";
  //     if (params == null) {
  //       return {"d": params};
  //     }
  //     if (params is Map<String, dynamic>) {
  //       m = jsonEncode(params);
  //     } else if (params is String) {
  //       m = params;
  //     } else {
  //       m = "$params";
  //     }
  //     return {"m": RsaUtil.encrypter.encrypt(m).base64};
  //   } catch (err) {}
  //
  //   var param = {'d': params};
  //   return param;
  // }
}
