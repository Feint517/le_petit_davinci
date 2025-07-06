import 'package:le_petit_davinci/data/models/user_model.dart';
import 'package:le_petit_davinci/data/network/api_client.dart';
import 'package:le_petit_davinci/data/network/api_routes.dart';

class UserRepository {
  final _dio = ApiClient().dio;

  Future<UserModel> fetchUserProfile() async {
    final response = await _dio.get(ApiRoutes.userProfile);
    return UserModel.fromJson(response.data);
  }

  Future<void> login(String email, String password) async {
    await _dio.post(
      ApiRoutes.login,
      data: {'email': email, 'password': password},
    );
  }
}
