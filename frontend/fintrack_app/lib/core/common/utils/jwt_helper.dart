import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fintrack_app/features/auth/data/models/user_model.dart';

const accessTokenKey = "accessToken";
const refreshTokenKey = "refreshToken";

final _secureStorage = FlutterSecureStorage();

Future<void> saveTokens(String accessToken, String refreshToken) async {
  await _secureStorage.write(key: accessTokenKey, value: accessToken);
  await _secureStorage.write(key: refreshTokenKey, value: refreshToken);
}

Future<String?> getJwtToken(FlutterSecureStorage secureStorage) async {
  return await secureStorage.read(key: accessTokenKey);
}

Future<UserModel> decodeJwtToken(String body) async {
  final data = jsonDecode(body);
  final String accessToken = data['accessToken'];
  final String refreshToken = data['refreshToken'];

  await saveTokens(accessToken, refreshToken);

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

Future<bool> isStillLoggedIn() async {
  final accessToken = await _secureStorage.read(key: accessTokenKey);

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

Future<UserModel?> getUserInfo() async {
  final isLoggedIn = await isStillLoggedIn();

  if (!isLoggedIn) {
    return null;
  }

  final accessToken = await _secureStorage.read(key: accessTokenKey);
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
