import 'dart:convert';

class User {
  final String id;
  final String name;
  final String gender;
  final int age;
  final String job;

  User(this.id, this.name, this.gender, this.age, this.job);

  factory User.fromJsonString(String jsonString) {
    JsonCodec codec = new JsonCodec();
    return User.fromJson(codec.decode(jsonString));
  }

  factory User.fromJson(dynamic json) {
    String id = json['id'];
    String name = json['name'];
    String gender = json['gender'];
    int age = json['age'];
    String job = json['job'];

    return User(id, name, gender, age, job);
  }
}