import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final String? token;
  final String? error;

  LoginResponse({this.token, this.error});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json['token'],
        error: json['error'],
      );

  Map<String, dynamic> toJson() => {
        if (token != null) 'token': token,
        if (error != null) 'error': error,
      };

  bool get isSuccess => token != null;
}
