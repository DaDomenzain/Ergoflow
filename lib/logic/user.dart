import 'package:cloud_firestore/cloud_firestore.dart';

class FBUser {
  String? id;
  int height;
  int weight;
  int age;
  String sex;
  String name;
  String avatar;
  String email;

  FBUser({
    this.id,
    required this.email,
    required this.name,
    required this.age,
    required this.sex,
    required this.height,
    required this.weight,
    required this.avatar,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'age': age,
        'sex': sex,
        'weight': weight,
        'height': height,
        'avatar': avatar
      };

  factory FBUser.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return FBUser(
      id: document.id,
      email: data['email'],
      name: data['name'],
      age: data['age'],
      sex: data['sex'],
      weight: data['weight'],
      height: data['height'],
      avatar: data['avatar'],
    );
  }
}
