class Failure implements Exception {
  const Failure({required this.message, this.code});

  final String message;
  final int? code;

  Failure copyWith({String? message, int? code}) {
    return Failure(message: message ?? this.message, code: code ?? this.code);
  }

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}
