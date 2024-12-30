import 'dart:async';

import 'package:fintrack_app/core/common/utils/error_parser.dart';
import 'package:fintrack_app/core/common/utils/http_helper.dart';
import 'package:fintrack_app/core/common/utils/jwt_helper.dart';
import 'package:fintrack_app/core/common/utils/status_codes.dart';
import 'package:fintrack_app/core/constants/exceptions.dart';
import 'package:fintrack_app/features/auth/data/models/user_model.dart';

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
  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final user = await getUserInfo();

      return user;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await postRequest("/users/login", {
        'email': email,
        'password': password,
      });

      if (!isSuccessfulResponse(response.statusCode)) {
        throw parseError(response);
      }

      final user = await decodeJwtToken(response.body);

      return user;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await postRequest("/users/register", {
        'email': email,
        'name': name,
        'password': password,
      });

      if (!isSuccessfulResponse(response.statusCode)) {
        throw parseError(response);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> verifyEmail({required int code}) async {
    try {
      final response = await postRequest("/users/verify-email", {
        'code': code,
      });

      if (!isSuccessfulResponse(response.statusCode)) {
        throw parseError(response);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
