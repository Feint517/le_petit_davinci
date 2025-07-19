import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/data/models/requests/login_request.dart';
import 'package:le_petit_davinci/data/models/requests/logout_request.dart';
import 'package:le_petit_davinci/data/models/responses/login_response.dart';
import 'package:le_petit_davinci/data/models/responses/logout_response.dart';
import 'package:le_petit_davinci/data/network/api_routes.dart';
import 'package:le_petit_davinci/features/authentication/views/login.dart';
import 'package:le_petit_davinci/features/home/views/home.dart';
import 'package:le_petit_davinci/features/onboarding/views/questions_intro.dart';
import 'package:le_petit_davinci/services/api_service.dart';
import 'package:le_petit_davinci/services/storage_service.dart';

String isLoggedInKey = 'is_logged_in';
String isFirstTimeKey = 'is_first_time';
String authTokenKey = 'auth_token';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _dio = ApiService().dio;

  //* variables
  final deviceStorage = StorageService.instance;

  @override
  void onReady() async {
    await Future.delayed(const Duration(seconds: 2));
    screenRedirect();
  }

  void screenRedirect() async {
    final isFirstTime = deviceStorage.read(isFirstTimeKey) ?? false;
    final isLoggedIn = deviceStorage.read(isLoggedInKey) ?? false;

    if (kDebugMode) {
      print('[Auth] isFirstTime => $isFirstTime');
      print('[Auth] isLoggedIn => $isLoggedIn');
    }

    if (isFirstTime) {
      Get.offAll(() => const QuestionsIntroScreen());
    } else if (isLoggedIn) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  Future<LoginResponse> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.get(
        ApiRoutes.login,
        data: LoginRequest(email: email, password: password).toJson(),
      );
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.data));
      } else {
        throw Exception(
          'Login failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch child data: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<LogoutResponse> logout({required int id}) async {
    try {
      final response = await _dio.get(
        ApiRoutes.logout,
        data: LogoutRequest(id: id).toJson(),
      );
      if (response.statusCode == 200) {
        return LogoutResponse.fromJson(jsonDecode(response.data));
      } else {
        throw Exception(
          'Logout failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print(e);
      throw Exception('Unexpected error: $e');
    }
  }

  void saveLoginStatus({required String token}) {
    deviceStorage.write(isLoggedInKey, true);
    deviceStorage.write(authTokenKey, token);
  }
}
