class SearchUser {
  int success;
  Data data;

  SearchUser({this.success, this.data});

  SearchUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String userName;
  String phone;
  String email;
  String address;
  Null userimage;

  Data(
      {this.id,
        this.userName,
        this.phone,
        this.email,
        this.address,
        this.userimage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userName = json['userName'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    userimage = json['userimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['userName'] = this.userName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['userimage'] = this.userimage;
    return data;
  }
}