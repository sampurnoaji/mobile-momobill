import 'package:equatable/equatable.dart';

class UserAccount extends Equatable {
  final String username;
  final String userid;
  final String fullname;
  final String email;
  final String phone;
  final String createAt;
  final String picture;
  final List<Address> addresses;

  UserAccount(
      {this.username,
      this.userid,
      this.fullname,
      this.email,
      this.phone,
      this.createAt,
      this.picture,
      this.addresses});

  @override
  List<Object> get props =>
      [username, userid, fullname, email, phone, createAt, picture, addresses];
}

class Address extends Equatable {
  final String tag;
  final String address;
  final String latitude;
  final String longitude;

  Address({this.tag, this.address, this.latitude, this.longitude});

  @override
  List<Object> get props => [tag, address, latitude, longitude];
}
