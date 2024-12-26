import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fintrack_app/core/constants/exceptions.dart';
import 'package:fintrack_app/core/constants/server_constants.dart';
import 'package:http/http.dart' as http;

Future<http.Response> postRequest(
  String path,
  Map<String, dynamic> body,
) async {
  final url = Uri.parse("${ServerConstants.baseUrl}$path");

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
    throw ServerException("Failed to connect to the server. Please try again.");
  } on TimeoutException catch (_) {
    throw ServerException("Request timeout. Please try again later.");
  } on http.ClientException catch (_) {
    throw ServerException("Failed to connect to the server. Please try again.");
  } catch (e) {
    throw ServerException("An unexpected error occurred: ${e.toString()}");
  }
}

Future<http.Response> getRequest(String path) async {
  final url = Uri.parse("${ServerConstants.baseUrl}$path");

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return response;
  } on SocketException catch (_) {
    throw ServerException("Failed to connect to the server. Please try again.");
  } on TimeoutException catch (_) {
    throw ServerException("Request timeout. Please try again later.");
  } on http.ClientException catch (_) {
    throw ServerException("Failed to connect to the server. Please try again.");
  } catch (e) {
    throw ServerException("An unexpected error occurred: ${e.toString()}");
  }
}

Future<http.Response> deleteRequest(String path) async {
  final url = Uri.parse("${ServerConstants.baseUrl}$path");

  try {
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return response;
  } on SocketException catch (_) {
    throw ServerException("Failed to connect to the server. Please try again.");
  } on TimeoutException catch (_) {
    throw ServerException("Request timeout. Please try again later.");
  } on http.ClientException catch (_) {
    throw ServerException("Failed to connect to the server. Please try again.");
  } catch (e) {
    throw ServerException("An unexpected error occurred: ${e.toString()}");
  }
}

Future<http.Response> patchRequest(
  String path,
  Map<String, dynamic> body,
) async {
  final url = Uri.parse("${ServerConstants.baseUrl}$path");

  try {
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    return response;
  } on SocketException catch (_) {
    throw ServerException("Failed to connect to the server. Please try again.");
  } on TimeoutException catch (_) {
    throw ServerException("Request timeout. Please try again later.");
  } on http.ClientException catch (_) {
    throw ServerException("Failed to connect to the server. Please try again.");
  } catch (e) {
    throw ServerException("An unexpected error occurred: ${e.toString()}");
  }
}
