import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:le_petit_davinci/core/network/auth_interceptor.dart';
import '../data/network/api_routes.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late final Dio dio;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiRoutes.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 45),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    //* Add auth interceptor (must be first to handle auth)
    dio.interceptors.add(AuthInterceptor(dio));

    //* Add logger interceptor (for debugging)
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
      ),
    );
  }
}
