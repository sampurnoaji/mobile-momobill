import 'package:momobill/features/account/domain/models/user_account.dart';

class UserAccountResponse extends UserAccount {
  final String username;
  final String userid;
  final String fullname;
  final String email;
  final String phone;
  final String createAt;
  final String picture;
  final List<AddressResponse> address;

  UserAccountResponse(
      {this.username,
      this.userid,
      this.fullname,
      this.email,
      this.phone,
      this.createAt,
      this.picture,
      this.address});

  factory UserAccountResponse.fromJson(Map<String, dynamic> json) {
    var addressesResponse = json['addresses'] as List;
    List<AddressResponse> addresses = addressesResponse.map((e) => AddressResponse.fromJson(e)).toList();

    return UserAccountResponse(
      username: json['user-name'],
      userid: json['user-id'],
      fullname: json['full-name'],
      email: json['email'],
      phone: json['phone'],
      createAt: json['create-at'],
      picture: json['pictures'],
      address: addresses
    );
  }
}

class AddressResponse {
  final String tag;
  final String address;
  final String latitude;
  final String longitude;

  AddressResponse({this.tag, this.address, this.latitude, this.longitude});

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      tag: json['tags'],
      address: json['address'],
      latitude: json['latitide'],
      longitude: json["longitude"]
    );
  }
}