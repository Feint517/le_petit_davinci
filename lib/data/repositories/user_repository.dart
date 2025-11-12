import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/data/models/responses/user_data_response.dart';
import 'package:le_petit_davinci/services/api_service.dart';
import 'package:le_petit_davinci/services/storage_service.dart';
import 'package:le_petit_davinci/data/network/api_routes.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _dio = ApiService().dio;
  final _storage = StorageService.instance;

  Future<UserDataResponse> fetchUserProfile() async {
    try {
      // Get the selected profile ID
      final selectedProfile = _storage.getSelectedProfile();
      if (selectedProfile == null) {
        throw Exception('No profile selected. Please select a profile first.');
      }

      final profileId = selectedProfile.id;

      // Use GET request with profile ID in the URL
      final response = await _dio.get(
        ApiRoutes.fetchChildData(profileId),
      );

      if (response.statusCode == 200) {
        // response.data is already a Map<String, dynamic>, no need for jsonDecode
        return UserDataResponse.fromJson(response.data);
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
