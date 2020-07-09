class LilyResponse {
  final String data;
  final String message;

  LilyResponse({this.data, this.message});

  factory LilyResponse.fromJson(Map<String, dynamic> json) => LilyResponse(
        data: json['data'],
        message: json['message'],
      );
}
