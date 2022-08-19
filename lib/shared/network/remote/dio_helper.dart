import 'package:dio/dio.dart';

class DioHelper {
  // static Dio dio;
  static var dio = Dio();
  static init() {
    print('Dio init method');
    dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
      receiveTimeout: 5000,
      connectTimeout: 5000
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {

    return await dio.get(url, queryParameters: query);
  }
}
