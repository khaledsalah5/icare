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
  //late Map<String, dynamic> users1 ;
  late List users;

  Future<String> getData() async {
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };

    // var request =
    //     http.Request('GET', Uri.parse('https://gorest.co.in/public/v2/users'));
    // request.headers.addAll(headers);
    // http.StreamedResponse response2 = await request.send();
    // final respStr = await response2.stream.bytesToString();
    // users1 = jsonDecode(respStr);

    final response1 =
        await http.get(Uri.parse('https://gorest.co.in/public/v2/users'));

    users = jsonDecode(response1.body);
    print(users);

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
      appBar: AppBar(
        title: const Text("Users"),
        backgroundColor: const Color.fromARGB(1000, 21, 186, 217),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: users == null ? 0 : users.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    print(users[index]['name']);
                    final result = await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return UserDataScreen(
                          userName: users[index]['name'],
                          gender: users[index]['gender'],
                          email: users[index]['email'],
                          status: users[index]['status'],
                          id: users[index]['id'],

                          //age:users[index]['age']

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
                              users[index]['name'],
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              users[index]['email'],
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          
                          //users[index]['Specialization],

                          users[index]['gender'],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('Add User');
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddModifyUserScreen()),
          );
          if (result == 201) {
            setState(() {
              getData();
            });
          }
        },
        backgroundColor: const Color.fromARGB(255, 49, 204, 211),
        child: const Icon(
          Icons.add,
          size: 25.0,
        ),
      ),
    );
  }
}
