class BaseResponseModel<T> {
  final T? body;
  final String? example;

  BaseResponseModel({this.body, this.example});

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return BaseResponseModel<T>(
      body: json['body'] != null ? fromJsonT(json['body']) : null,
      example: json['example'] as String?,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      if (body != null) 'body': toJsonT(body!),
      if (example != null) 'example': example,
    };
  }
}
