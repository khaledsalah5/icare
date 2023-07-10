
import 'package:flutter/material.dart';

class LoginCredentials {
  final String email;
  final String password;

  LoginCredentials(this.email, this.password);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class User {
  int id;
  String username;
  String password;
  String email;
  String phoneNumber;
  String age;
  String job;
  String gender;
  String speciality;
  String department;
  String address;

  User({
    this.id:0,
    this.username:'',
    this.password='',
    this.email:'',
    this.phoneNumber:'',
    this.age:'',
    this.job:"",
    this.gender:"",
    this.speciality:"",
    this.department:"",
    this.address:"",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      age: json['age'],
      job: json['job'],
      gender: json['gender'],
      speciality: json['speciality'],
      department: json['department'],
      address: json['address'],
    );
  }
}

late String PatientName = ' Mohamed Ali';
late String PatientAge = ' 25';
late String PatientNum = ' 01032901179';
late String PatientGender = 'Male';



Widget iconData(String name, String value) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Stack(alignment: Alignment.center, children: [
      Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(15)),
      ),
      Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(246, 255, 255, 255),
            borderRadius: BorderRadius.circular(15)),
        width: 50,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            Text(value),
          ],
        ),
      ),
    ]),
  );
}