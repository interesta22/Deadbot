
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String email;
  final String name;
  final String phone;
  final String password;

  UserModel(
      {required this.userId,
      required this.email,
      required this.name,
      required this.phone,
      required this.password});

  toJson() {
    return {'Name': name, 'Phone': phone, 'Email': email, 'Password': password};
  }

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document) {
    Map data = document.data()!;
    return UserModel(
      userId: document.id,
      email: data['Email'],
      name: data['Name'] ,
      phone: data['Phone'] ,
      password: data['Password']
    );
  }
}
