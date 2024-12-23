import 'dart:convert';

import 'package:fintrack_app/core/constants/exceptions.dart';
import 'package:fintrack_app/core/constants/server_constants.dart';
import 'package:fintrack_app/features/auth/data/models/user_model.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import "package:http/http.dart" as http;

abstract interface class AuthRemoteDataSource {
  Future register({
    required String email,
    required String password,
    required String name,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel?> getCurrentUserData() {
    // TODO: implement getCurrentUserData
    throw UnimplementedError();
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("${ServerConstants.baseUrl}/users/login");

    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw const ServerException("Failed to login");
    }

    final dynamic data = jsonDecode(response.body);

    final String accessToken = data['accessToken'];

    final JWT jwt = JWT.decode(accessToken);

    final String subject = jwt.payload['sub'];
    final String jwtEmail = jwt.payload['email'];
    final String name = jwt.payload['name'];

    return UserModel(
      id: subject,
      email: jwtEmail,
      name: name,
    );
  }

  @override
  Future register({
    required String email,
    required String password,
    required String name,
  }) async {
    final url = Uri.parse("${ServerConstants.baseUrl}/users/register");

    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'name': name,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw const ServerException("Failed to register");
    }
  }
}
