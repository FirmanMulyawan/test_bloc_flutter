class BaseResponse {
  String? message;
  String? msgType;
  String? data;

  BaseResponse({this.message, this.msgType, this.data});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    msgType = json['msg_type'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['msg_type'] = msgType;
    data['data'] = this.data;
    return data;
  }
}
