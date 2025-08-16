import 'package:wisebud/models/trip.dart';

class User {
  String id;
  String? email;

  List<Trip>? trips = [];

  User({required this.id, this.email});

  factory User.from(Map<String, dynamic> map){
    return User(id: map['id'], email: map['email']);
  }
}
