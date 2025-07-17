class ResponseModel<T extends Serializable> {
  String? message;
  String? messageType;
  T? data;

  ResponseModel({
    this.message,
    this.messageType,
    this.data,
  });

  ResponseModel.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    message = json['message'];
    messageType = json['msg_type'];
    if (json['data'] != null) {
      data = create(json['data']);
    }
  }

  ResponseModel.ignoreDataFromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageType = json['msg_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['message'] = message;
    json['msg_type'] = messageType;
    json['data'] = data?.toJson();
    return json;
  }
}

class ListResponseModel<T extends Serializable> {
  String? message;
  String? messageType;
  List<T>? data;

  ListResponseModel({
    this.message,
    this.messageType,
    this.data,
  });

  ListResponseModel.fromJson(
      Map<String, dynamic> json, Function(List<dynamic>) build) {
    message = json['message'];
    messageType = json['msg_type'];
    if (json['data'] != null) {
      data = build(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['message'] = message;
    json['msg_type'] = messageType;
    json['data'] = data?.toList();
    return json;
  }
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
