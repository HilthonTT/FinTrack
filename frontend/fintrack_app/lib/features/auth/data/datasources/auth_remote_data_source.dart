import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fintrack_app/core/common/utils/error_parser.dart';
import 'package:fintrack_app/core/common/utils/status_codes.dart';
import 'package:fintrack_app/core/constants/exceptions.dart';
import 'package:fintrack_app/core/constants/server_constants.dart';
import 'package:fintrack_app/features/auth/data/models/user_model.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<void> register({
    required String email,
    required String password,
    required String name,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();

  Future<void> verifyEmail({required int code});
}

final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final String _baseUrl = ServerConstants.baseUrl;

  @override
  Future<UserModel?> getCurrentUserData() {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _postRequest("/users/login", {
      'email': email,
      'password': password,
    });

    if (!isSuccessfulResponse(response.statusCode)) {
      throw parseError(response);
    }

    final data = jsonDecode(response.body);
    final String accessToken = data['accessToken'];

    final JWT jwt = JWT.decode(accessToken);
    final String userId = jwt.payload['sub'];
    final String userEmail = jwt.payload['email'];
    final String userName = jwt.payload['name'];

    return UserModel(id: userId, email: userEmail, name: userName);
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await _postRequest("/users/register", {
      'email': email,
      'name': name,
      'password': password,
    });

    if (!isSuccessfulResponse(response.statusCode)) {
      throw parseError(response);
    }
  }

  @override
  Future<void> verifyEmail({required int code}) async {
    final response = await _postRequest("/users/verify-email", {
      'code': code,
    });

    if (!isSuccessfulResponse(response.statusCode)) {
      throw parseError(response);
    }
  }

  Future<http.Response> _postRequest(
    String path,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse("$_baseUrl$path");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      return response;
    } on SocketException catch (_) {
      throw ServerException(
          "No internet connection. Please check your network.");
    } on TimeoutException catch (_) {
      throw ServerException("Request timeout. Please try again later.");
    } on http.ClientException catch (_) {
      throw ServerException(
          "Failed to connect to the server. Please try again.");
    } catch (e) {
      throw ServerException("An unexpected error occurred: ${e.toString()}");
    }
  }
}
