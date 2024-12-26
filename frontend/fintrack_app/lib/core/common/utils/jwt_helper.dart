import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fintrack_app/features/auth/data/models/user_model.dart';

Future<void> saveTokens(
  FlutterSecureStorage secureStorage,
  String accessToken,
  String refreshToken,
) async {
  await secureStorage.write(key: 'accessToken', value: accessToken);
  await secureStorage.write(key: 'refreshToken', value: refreshToken);
}

Future<UserModel> decodeJwtToken(
  FlutterSecureStorage secureStorage,
  String body,
) async {
  final data = jsonDecode(body);
  final String accessToken = data['accessToken'];
  final String refreshToken = data['refreshToken'];

  await saveTokens(secureStorage, accessToken, refreshToken);

  final JWT jwt = JWT.decode(accessToken);
  final String userId = jwt.payload['sub'];
  final String userEmail = jwt.payload['email'];
  final String userName = jwt.payload['name'];

  return UserModel(
    id: userId,
    email: userEmail,
    name: userName,
  );
}

Future<bool> isStillLoggedIn(FlutterSecureStorage secureStorage) async {
  final accessToken = await secureStorage.read(key: 'accessToken');

  if (accessToken == null) {
    return false;
  }

  try {
    final JWT jwt = JWT.decode(accessToken);
    final expClaim = jwt.payload['exp'];

    if (expClaim == null) {
      return false;
    }

    final expiryDate = DateTime.fromMillisecondsSinceEpoch(expClaim * 1000);

    return DateTime.now().isBefore(expiryDate);
  } catch (e) {
    return false;
  }
}

Future<UserModel?> getUserInfo(FlutterSecureStorage secureStorage) async {
  final isLoggedIn = await isStillLoggedIn(secureStorage);

  if (!isLoggedIn) {
    return null;
  }

  final accessToken = await secureStorage.read(key: 'accessToken');
  if (accessToken == null) {
    return null;
  }

  try {
    final JWT jwt = JWT.decode(accessToken);
    final String userId = jwt.payload['sub'];
    final String userEmail = jwt.payload['email'];
    final String userName = jwt.payload['name'];

    return UserModel(
      id: userId,
      email: userEmail,
      name: userName,
    );
  } catch (e) {
    return null;
  }
}
