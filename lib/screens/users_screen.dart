import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icare/screens/add_modify_user_screen.dart';
import 'package:icare/screens/user_data_screen.dart';
import 'package:icare/components/key.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late List users = [];

  Future<String> getData() async {
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('GET', Uri.parse('http://belalatef.pythonanywhere.com/User/all'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    users = jsonDecode(respStr);
    return 'Successfully Fetched data';
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New User',
        onPressed: () async {
          print('Add User');
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddModifyUserScreen("","",0,"Male","Doctor","","",
            "","",'')),
          );
          if (result == 201) {
            setState(() {
              getData();
            });
          }
        },
        backgroundColor: const Color(0xff066163),
        child: const Icon(
          Icons.add,
          size: 25.0,
        ),
      ),
      appBar: AppBar(
        title: const Text("Users"),
        backgroundColor: const Color(0xff066163),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              // ignore: unnecessary_null_comparison
              itemCount: users == null ? 0 : users.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    print(users[index]['username']);
                    final result = await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return UserDataScreen(
                          userName: users[index]['username'],
                          email: users[index]['email'],
                          gender: users[index]['gender'],
                          job: users[index]['job'],
                          address: users[index]['address'],
                          phone_number: users[index]['phone_number'],
                          age: users[index]['age'],
                          password: users[index]['password'],                         
                          id: users[index]['id'],
                          Specialization:users[index]['speciality'],
                        );
                      },
                      isScrollControlled: true,
                    );
                    if (result == 'yes') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Text(
                            'User Deleted successfully',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      setState(() {
                        getData();
                      });
                    }
                    if (result == 200) {
                      setState(() {
                        getData();
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 6.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              users[index]['username'],
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              users[index]['email'],
                              style: const TextStyle(
                                fontSize: 14.5,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          users[index]['job'],
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
