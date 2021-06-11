
class User {
  List<UserDetail> data;

  User({this.data});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(data: (json['data'] as List).map((i) => UserDetail.fromJson(i)).toList());
  }

}

class UserDetail {
  final int Id;
  final String userName;
  final String phone;
  final String email;
  final String address;

  UserDetail({
    this.Id,
    this.userName,
    this.phone,
    this.email,
    this.address
});

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      Id: json['Id'],
      userName: json['userName'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
    );
  }
}