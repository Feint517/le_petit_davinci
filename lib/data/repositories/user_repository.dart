import 'dart:convert' show jsonDecode;

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/data/models/responses/user_data_response.dart';
import 'package:le_petit_davinci/services/api_service.dart';
import 'package:le_petit_davinci/data/network/api_routes.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _dio = ApiService().dio;

  Future<UserDataResponse> fetchUserProfile() async {
    try {
      final response = await _dio.get(
        ApiRoutes.fetchChildData,
        data: {"id": "123"},
      );

      final decoded = jsonDecode(response.data); //? Convert String to Map

      return UserDataResponse.fromJson(decoded);
    } on DioException catch (e) {
      throw Exception('Failed to fetch child data: ${e.message}');
    }
  }

  Future<void> login(String email, String password) async {
    await _dio.post(
      ApiRoutes.login,
      data: {'email': email, 'password': password},
    );
  }
}
