import 'package:dio/dio.dart';

abstract class BaseRepo {
  Dio dio;

  BaseRepo() {
    BaseOptions options = new BaseOptions(
      baseUrl: "https://ld-open-api.herokuapp.com/api/v1/",
    );
    dio = new Dio(options);
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }
}
