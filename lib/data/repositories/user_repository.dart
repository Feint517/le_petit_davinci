import 'dart:convert' show jsonDecode;

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/data/models/requests/fetch_user_data_request.dart';
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
        data: FetchUserDataRequest(id: '123').toJson(),
      );

      if (response.statusCode == 200) {
        return UserDataResponse.fromJson(jsonDecode(response.data));
      } else {
        throw Exception(
          'Data fetching failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch child data: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
