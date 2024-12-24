import 'package:fintrack_app/core/errors/custom_error.dart';

final class CustomProblemDetails {
  final String type;
  final String title;
  final int status;
  final String detail;
  final List<CustomError> errors;

  const CustomProblemDetails({
    required this.type,
    required this.title,
    required this.status,
    required this.detail,
    required this.errors,
  });

  factory CustomProblemDetails.fromJson(Map<String, dynamic> json) {
    return CustomProblemDetails(
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? 0,
      detail: json['detail'] ?? '',
      errors: (json['errors'] as List?)
              ?.map((e) => CustomError.fromJson(e))
              .toList() ??
          [],
    );
  }
}
