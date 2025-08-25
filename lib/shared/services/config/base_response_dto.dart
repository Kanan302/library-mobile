class BaseResponseDto<T> {
  final int statusCode;
  final String message;
  final T data;

  BaseResponseDto({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory BaseResponseDto.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return BaseResponseDto(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: fromJsonT(json['data']),
    );
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': toJsonT(data),
    };
  }
}
