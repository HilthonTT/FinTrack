import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fintrack_app/core/constants/exceptions.dart';
import 'package:fintrack_app/core/errors/custom_problem_details.dart';

CustomProblemDetails parseError(http.Response response) {
  try {
    final data = _decodeResponse(response.body);

    final problemDetails = _extractProblemDetails(data);

    _handleErrorMessages(problemDetails);

    return problemDetails;
  } on ServerException catch (_) {
    rethrow; // If it's a ServerException, rethrow it.
  } catch (e) {
    throw ServerException("Something went wrong: ${e.toString()}");
  }
}

Map<String, dynamic> _decodeResponse(String body) {
  return jsonDecode(body) as Map<String, dynamic>;
}

CustomProblemDetails _extractProblemDetails(Map<String, dynamic> data) {
  return CustomProblemDetails.fromJson(data);
}

void _handleErrorMessages(CustomProblemDetails problemDetails) {
  if (problemDetails.errors.isNotEmpty) {
    final message = _getErrorMessages(problemDetails);

    throw ServerException(message);
  } else {
    throw ServerException(problemDetails.detail);
  }
}

String _getErrorMessages(CustomProblemDetails problemDetails) {
  final errorMessages =
      problemDetails.errors.map((error) => error.description).toList();

  return "Server returned an error:\n${errorMessages.first}";
}
