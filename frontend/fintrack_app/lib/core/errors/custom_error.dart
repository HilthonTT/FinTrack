enum ErrorType {
  failure,
  falidation,
  problem,
  notFound,
  conflict,
}

final class CustomError {
  final String code;
  final String description;
  final ErrorType type;

  const CustomError({
    required this.code,
    required this.description,
    required this.type,
  });

  factory CustomError.fromJson(Map<String, dynamic> json) {
    return CustomError(
      code: json['code'] ?? '',
      description: json['description'] ?? '',
      type: ErrorType.values[json['type'] ?? 0],
    );
  }
}
