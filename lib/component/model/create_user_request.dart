class CreateUserRequest {
  String? name;
  String? job;

  CreateUserRequest({this.name, this.job});

  CreateUserRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    job = json['job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['job'] = job;
    return data;
  }
}
