// To parse this JSON data, do
//
//     final userIdResponse = userIdResponseFromJson(jsonString);

import 'dart:convert';

UserIdResponse userIdResponseFromJson(String str) =>
    UserIdResponse.fromJson(json.decode(str));

String userIdResponseToJson(UserIdResponse data) => json.encode(data.toJson());

class UserIdResponse {
  Data data;
  Support support;

  UserIdResponse({
    required this.data,
    required this.support,
  });

  factory UserIdResponse.fromJson(Map<String, dynamic> json) => UserIdResponse(
        data: Data.fromJson(json["data"]),
        support: Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "support": support.toJson(),
      };
}

class Data {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

class Support {
  String url;
  String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}
